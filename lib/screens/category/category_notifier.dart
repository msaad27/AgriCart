import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/category_model.dart';
 
import 'category_repository.dart';

final categoryNotifierProvider =
    StateNotifierProvider<CategoryNotifier, CategoryState>(
  (ref) => CategoryNotifier(CategoryRepository()),
);

class CategoryNotifier extends StateNotifier<CategoryState> {
  final CategoryRepository _repository;
  int _page = 0;
  bool _hasReachedEnd = false;

  CategoryNotifier(this._repository) : super(const CategoryInitial()) {
    fetchCategories();
  }

  bool get hasReachedEnd => _hasReachedEnd;

  Future<void> fetchCategories() async {
    if (state is CategoryLoading || _hasReachedEnd) return;

    if (_page == 0) {
      state = const CategoryLoading();
    }

    try {
      final categories = await _repository.fetchCategories(_page);
      if (categories.isEmpty) {
        _hasReachedEnd = true;
        if (_page == 0) {
          state = const CategoryEmpty();
        } else {
          state = CategorySuccess(
              List.from((state as CategorySuccess).categories));
        }
        return;
      }

      final currentList = state is CategorySuccess
          ? (state as CategorySuccess).categories
          : <Category>[];

      final updatedList = [...currentList, ...categories];
      state = CategorySuccess(updatedList);
      _page++;
    } catch (e) {
      state = CategoryError(e.toString());
    }
  }

  Future<void> refresh() async {
    _page = 0;
    _hasReachedEnd = false;
    await fetchCategories();
  }
}

abstract class CategoryState {
  const CategoryState();
}

class CategoryInitial extends CategoryState {
  const CategoryInitial();
}

class CategoryLoading extends CategoryState {
  const CategoryLoading();
}

class CategorySuccess extends CategoryState {
  final List<Category> categories;
  const CategorySuccess(this.categories);
}

class CategoryEmpty extends CategoryState {
  const CategoryEmpty();
}

class CategoryError extends CategoryState {
  final String message;
  const CategoryError(this.message);
}
