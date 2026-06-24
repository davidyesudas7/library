import 'package:library_client/library_client.dart';
import 'package:library_flutter/core/network/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_remote_datasource.g.dart';

@riverpod
BookRemoteDataSource bookRemoteDataSource(Ref ref) {
  final client = ref.watch(apiClientProvider);
  return BookRemoteDataSource(client);
}

class BookRemoteDataSource {
  final Client _client;

  BookRemoteDataSource(this._client);

  Future<List<Book>> getBooks({int? categoryId, String? searchQuery}) async {
    return await _client.book.getBooks(categoryId, searchQuery);
  }

  Future<Book> createBook(Book book) async {
    return await _client.book.create(book);
  }

  Future<Book> updateBook(Book book) async {
    return await _client.book.update(book);
  }

  Future<Book> deleteBook(Book book) async {
    return await _client.book.delete(book);
  }
}
