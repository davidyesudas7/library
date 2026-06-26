import 'package:dartz/dartz.dart';
import 'package:library_client/library_client.dart';

abstract class CategoryRepository {
  Future<Either<String, List<Category>>> getAllCategories();
  Future<Either<String, List<Category>>> searchCategories(String query);
  Future<Either<String, Category>> createCategory(Category category);
  Future<Either<String, Category>> updateCategory(Category category);
  Future<Either<String, Category>> deleteCategory(Category category);
}
