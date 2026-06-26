import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:library_client/library_client.dart';
import '../../data/repositories/book_repository_impl.dart';

part 'book_providers.g.dart';

// @riverpod
// Future<List<Book>> books(Ref ref) async {
//   final repository = ref.watch(bookRepositoryProvider);
//   final result = await repository.getBooks();
//   return result.fold(
//     (failure) => throw Exception(failure),
//     (books) => books,
//   );
// }

@riverpod
Future<List<Book>> filteredBooks(
  Ref ref, {
  int? categoryId,
  String? searchQuery,
}) async {
  final repository = ref.watch(bookRepositoryProvider);
  final result = await repository.getBooks(
    categoryId: categoryId,
    searchQuery: searchQuery,
  );
  return result.fold(
    (failure) => throw Exception(failure),
    (books) {
      return books;
    },
  );
}

@Riverpod(keepAlive: true)
class BookNotifier extends _$BookNotifier {
  @override
  Future<void> build() async {}

  Future<void> createBook(Book book) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(bookRepositoryProvider);
      final result = await repository.createBook(book);
      return result.fold(
        (failure) => throw Exception(failure),
        (_) {
          ref.invalidate(filteredBooksProvider);
          return;
        },
      );
    });
  }

  Future<void> updateBook(Book book) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(bookRepositoryProvider);
      final result = await repository.updateBook(book);
      return result.fold(
        (failure) => throw Exception(failure),
        (_) {
          ref.invalidate(filteredBooksProvider);
          return;
        },
      );
    });
  }

  Future<void> deleteBook(Book book) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(bookRepositoryProvider);
      final result = await repository.deleteBook(book);
      return result.fold(
        (failure) => throw Exception(failure),
        (_) {
          ref.invalidate(filteredBooksProvider);
          return;
        },
      );
    });
  }
}
