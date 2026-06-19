import 'package:dartz/dartz.dart';
import 'package:library_client/library_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/book_remote_datasource.dart';

part 'book_repository_impl.g.dart';

@riverpod
BookRepository bookRepository(Ref ref) {
  final remoteDataSource = ref.watch(bookRemoteDataSourceProvider);
  return BookRepositoryImpl(remoteDataSource);
}

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource _remoteDataSource;

  BookRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<String, List<Book>>> getAllBooks() async {
    try {
      final books = await _remoteDataSource.getAllBooks();
      return Right(books);
    } catch (e) {
      return Left('Failed to fetch books: \${e.toString()}');
    }
  }

  @override
  Future<Either<String, List<Book>>> getBooksByCategory(int categoryId) async {
    try {
      final books = await _remoteDataSource.getBooksByCategory(categoryId);
      return Right(books);
    } catch (e) {
      return Left('Failed to fetch books by category: \${e.toString()}');
    }
  }

  @override
  Future<Either<String, Book>> createBook(Book book) async {
    try {
      final createdBook = await _remoteDataSource.createBook(book);
      return Right(createdBook);
    } catch (e) {
      return Left('Failed to create book: \${e.toString()}');
    }
  }

  @override
  Future<Either<String, Book>> updateBook(Book book) async {
    try {
      final updatedBook = await _remoteDataSource.updateBook(book);
      return Right(updatedBook);
    } catch (e) {
      return Left('Failed to update book: \${e.toString()}');
    }
  }

  @override
  Future<Either<String, Book>> deleteBook(Book book) async {
    try {
      final deletedBook = await _remoteDataSource.deleteBook(book);
      return Right(deletedBook);
    } catch (e) {
      return Left('Failed to delete book: \${e.toString()}');
    }
  }
}
