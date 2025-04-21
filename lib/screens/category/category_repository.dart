import '../../../models/category_model.dart';
import 'mock_categories.dart';

class CategoryRepository {
  static final int _pageSize = dummyCategories.toString().length ~/ 2;

  final List<Category> _mockData = dummyCategories;

  Future<List<Category>> fetchCategories(int page) async {
    await Future.delayed(const Duration(seconds: 1));
    final start = page * _pageSize;
    if (start >= _mockData.length) return [];
    final end = start + _pageSize;
    return _mockData.sublist(start, end > _mockData.length ? _mockData.length : end);
  }
}
