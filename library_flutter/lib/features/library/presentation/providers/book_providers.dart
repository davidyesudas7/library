import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:library_client/library_client.dart';
import '../../data/repositories/book_repository_impl.dart';

part 'book_providers.g.dart';

@riverpod
Future<List<Book>> books(Ref ref) async {
  final repository = ref.watch(bookRepositoryProvider);
  final result = await repository.getAllBooks();
  return result.fold(
    (failure) => throw Exception(failure),
    (books) => books,
  );
}

@riverpod
Future<List<Book>> booksByCategory(Ref ref, int categoryId) async {
  final repository = ref.watch(bookRepositoryProvider);
  final result = await repository.getBooksByCategory(categoryId);
  return result.fold(
    (failure) => throw Exception(failure),
    (books) => books,
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
