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
      where: (t) {
        Expression? where;
        if (categoryId != null) {
          where = t.categoryId.equals(categoryId);
        }
        if (searchQuery != null) {
          final searchExpr = t.title.ilike('%$searchQuery%');
          where = where != null ? (where & searchExpr) : searchExpr;
        }
        return where!;
      },
    );

    int totalPages = (toatalBooks / pageLimit).ceil();

    return PaginatedBooks(
      totalBooks: totalPages,
      currentPage: page ?? 1,
      booksPerPage: pageLimit,
      books: books,
    );
  }

  // Future<List<Book>> getByCategory(Session session, int categoryId) async {
  //   return await Book.db.find(
  //     session,
  //     where: (t) => t.categoryId.equals(categoryId),
  //     include: Book.include(category: Category.include()),
  //   );
  // }

  Future<Book> create(Session session, Book book) async {
    return await Book.db.insertRow(session, book);
  }

  Future<Book> update(Session session, Book book) async {
    return await Book.db.updateRow(session, book);
  }

  Future<Book> delete(Session session, Book book) async {
    return await Book.db.deleteRow(session, book);
  }
}
