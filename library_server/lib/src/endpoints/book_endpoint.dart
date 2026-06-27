import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class BookEndpoint extends Endpoint {
  Future<PaginatedBooks> getBooks(
    Session session,
    int? categoryId,
    String? searchQuery, {
    int? page,
    int? limit,
  }) async {
    try {
      final pageLimit = limit ?? await Book.db.count(session);
      int offset = ((page ?? 1) - 1) * (pageLimit);
      final books = await Book.db.find(
        session,
        where: (categoryId != null || searchQuery != null)
            ? (t) {
                Expression? where;
                if (categoryId != null) {
                  where = t.categoryId.equals(categoryId);
                }
                if (searchQuery != null) {
                  final searchExpr = t.title.ilike('%$searchQuery%');
                  where = where != null ? (where & searchExpr) : searchExpr;
                }
                return where!;
              }
            : null,
        include: Book.include(category: Category.include()),
        limit: pageLimit,
        offset: offset,
      );
      final toatalBooks = await Book.db.count(
        session,
        where: (categoryId != null || searchQuery != null)
            ? (t) {
                Expression? where;
                if (categoryId != null) {
                  where = t.categoryId.equals(categoryId);
                }
                if (searchQuery != null) {
                  final searchExpr = t.title.ilike('%$searchQuery%');
                  where = where != null ? (where & searchExpr) : searchExpr;
                }
                return where!;
              }
            : null,
      );

      int totalPages = (toatalBooks / pageLimit).ceil();

      return PaginatedBooks(
        totalBooks: totalPages,
        currentPage: page ?? 1,
        booksPerPage: pageLimit,
        books: books,
      );
    } catch (e) {
      throw Exception('Failed to fetch books: ${e.toString()}');
    }
  }

  Future<Book> getBookById(Session session, int id) async {
    final book = await Book.db.findById(session, id);
    if (book == null) {
      throw Exception('Book not found: $id');
    }
    return book;
  }

  Future<Book> create(Session session, Book book) async {
    try {
      return await Book.db.insertRow(session, book);
    } catch (e) {
      throw Exception('Failed to create book: ${e.toString()}');
    }
  }

  Future<Book> update(Session session, Book book) async {
    return await Book.db.updateRow(session, book);
  }

  Future<Book> delete(Session session, Book book) async {
    return await Book.db.deleteRow(session, book);
  }
}
