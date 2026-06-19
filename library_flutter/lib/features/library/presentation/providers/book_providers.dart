import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_client/library_client.dart';
import '../../data/repositories/book_repository_impl.dart';

final booksProvider = FutureProvider<List<Book>>((ref) async {
  final repository = ref.watch(bookRepositoryProvider);
  final result = await repository.getAllBooks();
  return result.fold(
    (failure) => throw Exception(failure),
    (books) => books,
  );
});

final booksByCategoryProvider = FutureProvider.family<List<Book>, int>((ref, categoryId) async {
  final repository = ref.watch(bookRepositoryProvider);
  final result = await repository.getBooksByCategory(categoryId);
  return result.fold(
    (failure) => throw Exception(failure),
    (books) => books,
  );
});

final bookNotifierProvider = AsyncNotifierProvider<BookNotifier, void>(BookNotifier.new);

class BookNotifier extends AsyncNotifier<void> {
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
          ref.invalidate(booksProvider);
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
          ref.invalidate(booksProvider);
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
          ref.invalidate(booksProvider);
          return;
        },
      );
    });
  }
}
