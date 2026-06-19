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
import 'category.dart' as _i2;
import 'package:library_client/src/protocol/protocol.dart' as _i3;

abstract class Book implements _i1.SerializableModel {
  Book._({
    this.id,
    required this.title,
    required this.author,
    required this.description,
    this.imageUrl,
    required this.isAvailableOnline,
    required this.isAvailableOffline,
    this.pdfUrl,
    required this.categoryId,
    this.category,
  });

  factory Book({
    int? id,
    required String title,
    required String author,
    required String description,
    String? imageUrl,
    required bool isAvailableOnline,
    required bool isAvailableOffline,
    String? pdfUrl,
    required int categoryId,
    _i2.Category? category,
  }) = _BookImpl;

  factory Book.fromJson(Map<String, dynamic> jsonSerialization) {
    return Book(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      author: jsonSerialization['author'] as String,
      description: jsonSerialization['description'] as String,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      isAvailableOnline: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isAvailableOnline'],
      ),
      isAvailableOffline: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isAvailableOffline'],
      ),
      pdfUrl: jsonSerialization['pdfUrl'] as String?,
      categoryId: jsonSerialization['categoryId'] as int,
      category: jsonSerialization['category'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Category>(
              jsonSerialization['category'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String author;

  String description;

  String? imageUrl;

  bool isAvailableOnline;

  bool isAvailableOffline;

  String? pdfUrl;

  int categoryId;

  _i2.Category? category;

  /// Returns a shallow copy of this [Book]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Book copyWith({
    int? id,
    String? title,
    String? author,
    String? description,
    String? imageUrl,
    bool? isAvailableOnline,
    bool? isAvailableOffline,
    String? pdfUrl,
    int? categoryId,
    _i2.Category? category,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Book',
      if (id != null) 'id': id,
      'title': title,
      'author': author,
      'description': description,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'isAvailableOnline': isAvailableOnline,
      'isAvailableOffline': isAvailableOffline,
      if (pdfUrl != null) 'pdfUrl': pdfUrl,
      'categoryId': categoryId,
      if (category != null) 'category': category?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookImpl extends Book {
  _BookImpl({
    int? id,
    required String title,
    required String author,
    required String description,
    String? imageUrl,
    required bool isAvailableOnline,
    required bool isAvailableOffline,
    String? pdfUrl,
    required int categoryId,
    _i2.Category? category,
  }) : super._(
         id: id,
         title: title,
         author: author,
         description: description,
         imageUrl: imageUrl,
         isAvailableOnline: isAvailableOnline,
         isAvailableOffline: isAvailableOffline,
         pdfUrl: pdfUrl,
         categoryId: categoryId,
         category: category,
       );

  /// Returns a shallow copy of this [Book]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Book copyWith({
    Object? id = _Undefined,
    String? title,
    String? author,
    String? description,
    Object? imageUrl = _Undefined,
    bool? isAvailableOnline,
    bool? isAvailableOffline,
    Object? pdfUrl = _Undefined,
    int? categoryId,
    Object? category = _Undefined,
  }) {
    return Book(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      isAvailableOnline: isAvailableOnline ?? this.isAvailableOnline,
      isAvailableOffline: isAvailableOffline ?? this.isAvailableOffline,
      pdfUrl: pdfUrl is String? ? pdfUrl : this.pdfUrl,
      categoryId: categoryId ?? this.categoryId,
      category: category is _i2.Category?
          ? category
          : this.category?.copyWith(),
    );
  }
}
