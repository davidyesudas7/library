import 'package:dartz/dartz.dart';
import 'package:library_client/library_client.dart';

abstract class BookRepository {
  Future<Either<String, List<Book>>> getBooks({int? categoryId, String? searchQuery});
  Future<Either<String, Book>> createBook(Book book);
  Future<Either<String, Book>> updateBook(Book book);
  Future<Either<String, Book>> deleteBook(Book book);
}
