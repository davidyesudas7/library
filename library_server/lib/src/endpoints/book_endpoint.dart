import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class BookEndpoint extends Endpoint {
  Future<List<Book>> getBooks(
    Session session,
    int? categoryId,
    String? searchQuery,
  ) async {
    if (categoryId == null && searchQuery == null) {
      return await Book.db.find(
        session,
        include: Book.include(category: Category.include()),
      );
    }
    if (categoryId != null && searchQuery == null) {
      return await Book.db.find(
        session,
        where: (t) => t.categoryId.equals(categoryId),
        include: Book.include(category: Category.include()),
      );
    }
    if (categoryId == null && searchQuery != null) {
      return await Book.db.find(
        session,
        where: (t) => t.title.ilike('%$searchQuery%'),
        include: Book.include(category: Category.include()),
      );
    }
    return await Book.db.find(
      session,
      where: (t) =>
          t.categoryId.equals(categoryId) & t.title.ilike('%$searchQuery%'),
      include: Book.include(category: Category.include()),
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
