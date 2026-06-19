import 'package:library_client/library_client.dart';
import 'package:library_flutter/core/network/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRemoteDataSourceProvider = Provider<CategoryRemoteDataSource>((ref) {
  final client = ref.watch(apiClientProvider);
  return CategoryRemoteDataSource(client);
});

class CategoryRemoteDataSource {
  final Client _client;

  CategoryRemoteDataSource(this._client);

  Future<List<Category>> getAllCategories() async {
    return await _client.category.getAll();
  }

  Future<Category> createCategory(Category category) async {
    return await _client.category.create(category);
  }

  Future<Category> updateCategory(Category category) async {
    return await _client.category.update(category);
  }

  Future<Category> deleteCategory(Category category) async {
    return await _client.category.delete(category);
  }
}
