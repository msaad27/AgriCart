import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'category_repository.dart';
import '../../../models/category_model.dart';

final categoryRepositoryProvider = Provider((ref) => CategoryRepository());

final categoryListProvider = StateNotifierProvider<CategoryNotifier, AsyncValue<List<Category>>>(
  (ref) => CategoryNotifier(ref),
);

class CategoryNotifier extends StateNotifier<AsyncValue<List<Category>>> {
  final Ref ref;
  int _currentPage = 0;
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  CategoryNotifier(this.ref) : super(const AsyncLoading()) {
    fetchCategories();
  }

  Future<void> fetchCategories({bool loadMore = false}) async {
    if (loadMore && !_hasMore) return;

    if (!loadMore) state = const AsyncLoading();

    try {
      final newItems = await ref.read(categoryRepositoryProvider).fetchCategories(_currentPage);
      _hasMore = newItems.isNotEmpty;
      _currentPage += 1;

      if (state is AsyncData<List<Category>> && loadMore) {
        final currentList = (state as AsyncData<List<Category>>).value;
        state = AsyncData([...currentList, ...newItems]);
      } else {
        state = AsyncData(newItems);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
