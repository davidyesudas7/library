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

abstract class DownloadedBook implements _i1.SerializableModel {
  DownloadedBook._({
    this.id,
    required this.userName,
    required this.parish,
    this.email,
    this.phone,
    required this.bookId,
    this.book,
  });

  factory DownloadedBook({
    int? id,
    required String userName,
    required String parish,
    String? email,
    String? phone,
    required int bookId,
    _i2.Book? book,
  }) = _DownloadedBookImpl;

  factory DownloadedBook.fromJson(Map<String, dynamic> jsonSerialization) {
    return DownloadedBook(
      id: jsonSerialization['id'] as int?,
      userName: jsonSerialization['userName'] as String,
      parish: jsonSerialization['parish'] as String,
      email: jsonSerialization['email'] as String?,
      phone: jsonSerialization['phone'] as String?,
      bookId: jsonSerialization['bookId'] as int,
      book: jsonSerialization['book'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Book>(jsonSerialization['book']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String userName;

  String parish;

  String? email;

  String? phone;

  int bookId;

  _i2.Book? book;

  /// Returns a shallow copy of this [DownloadedBook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DownloadedBook copyWith({
    int? id,
    String? userName,
    String? parish,
    String? email,
    String? phone,
    int? bookId,
    _i2.Book? book,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DownloadedBook',
      if (id != null) 'id': id,
      'userName': userName,
      'parish': parish,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      'bookId': bookId,
      if (book != null) 'book': book?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DownloadedBookImpl extends DownloadedBook {
  _DownloadedBookImpl({
    int? id,
    required String userName,
    required String parish,
    String? email,
    String? phone,
    required int bookId,
    _i2.Book? book,
  }) : super._(
         id: id,
         userName: userName,
         parish: parish,
         email: email,
         phone: phone,
         bookId: bookId,
         book: book,
       );

  /// Returns a shallow copy of this [DownloadedBook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DownloadedBook copyWith({
    Object? id = _Undefined,
    String? userName,
    String? parish,
    Object? email = _Undefined,
    Object? phone = _Undefined,
    int? bookId,
    Object? book = _Undefined,
  }) {
    return DownloadedBook(
      id: id is int? ? id : this.id,
      userName: userName ?? this.userName,
      parish: parish ?? this.parish,
      email: email is String? ? email : this.email,
      phone: phone is String? ? phone : this.phone,
      bookId: bookId ?? this.bookId,
      book: book is _i2.Book? ? book : this.book?.copyWith(),
    );
  }
}
