import 'package:dartz/dartz.dart';
import 'package:library_client/library_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_datasource.dart';

part 'category_repository_impl.g.dart';

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  final remoteDataSource = ref.watch(categoryRemoteDataSourceProvider);
  return CategoryRepositoryImpl(remoteDataSource);
}

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource _remoteDataSource;

  CategoryRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<String, List<Category>>> getAllCategories() async {
    try {
      final categories = await _remoteDataSource.getAllCategories();
      return Right(categories);
    } catch (e) {
      return Left('Failed to fetch categories: \${e.toString()}');
    }
  }

  @override
  Future<Either<String, Category>> createCategory(Category category) async {
    try {
      final createdCategory = await _remoteDataSource.createCategory(category);
      return Right(createdCategory);
    } catch (e) {
      return Left('Failed to create category: \${e.toString()}');
    }
  }

  @override
  Future<Either<String, Category>> updateCategory(Category category) async {
    try {
      final updatedCategory = await _remoteDataSource.updateCategory(category);
      return Right(updatedCategory);
    } catch (e) {
      return Left('Failed to update category: \${e.toString()}');
    }
  }

  @override
  Future<Either<String, Category>> deleteCategory(Category category) async {
    try {
      final deletedCategory = await _remoteDataSource.deleteCategory(category);
      return Right(deletedCategory);
    } catch (e) {
      return Left('Failed to delete category: \${e.toString()}');
    }
  }
}
