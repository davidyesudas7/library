/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'book.dart' as _i2;
import 'package:library_client/src/protocol/protocol.dart' as _i3;

abstract class PaginatedBooks implements _i1.SerializableModel {
  PaginatedBooks._({
    required this.totalBooks,
    required this.currentPage,
    required this.booksPerPage,
    required this.books,
  });

  factory PaginatedBooks({
    required int totalBooks,
    required int currentPage,
    required int booksPerPage,
    required List<_i2.Book> books,
  }) = _PaginatedBooksImpl;

  factory PaginatedBooks.fromJson(Map<String, dynamic> jsonSerialization) {
    return PaginatedBooks(
      totalBooks: jsonSerialization['totalBooks'] as int,
      currentPage: jsonSerialization['currentPage'] as int,
      booksPerPage: jsonSerialization['booksPerPage'] as int,
      books: _i3.Protocol().deserialize<List<_i2.Book>>(
        jsonSerialization['books'],
      ),
    );
  }

  int totalBooks;

  int currentPage;

  int booksPerPage;

  List<_i2.Book> books;

  /// Returns a shallow copy of this [PaginatedBooks]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PaginatedBooks copyWith({
    int? totalBooks,
    int? currentPage,
    int? booksPerPage,
    List<_i2.Book>? books,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PaginatedBooks',
      'totalBooks': totalBooks,
      'currentPage': currentPage,
      'booksPerPage': booksPerPage,
      'books': books.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PaginatedBooksImpl extends PaginatedBooks {
  _PaginatedBooksImpl({
    required int totalBooks,
    required int currentPage,
    required int booksPerPage,
    required List<_i2.Book> books,
  }) : super._(
         totalBooks: totalBooks,
         currentPage: currentPage,
         booksPerPage: booksPerPage,
         books: books,
       );

  /// Returns a shallow copy of this [PaginatedBooks]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PaginatedBooks copyWith({
    int? totalBooks,
    int? currentPage,
    int? booksPerPage,
    List<_i2.Book>? books,
  }) {
    return PaginatedBooks(
      totalBooks: totalBooks ?? this.totalBooks,
      currentPage: currentPage ?? this.currentPage,
      booksPerPage: booksPerPage ?? this.booksPerPage,
      books: books ?? this.books.map((e0) => e0.copyWith()).toList(),
    );
  }
}
