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
import 'category.dart' as _i3;
import 'package:library_client/src/protocol/book.dart' as _i4;
import 'package:library_client/src/protocol/category.dart' as _i5;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i6;
export 'book.dart';
export 'category.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.Book) {
      return _i2.Book.fromJson(data) as T;
    }
    if (t == _i3.Category) {
      return _i3.Category.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Book?>()) {
      return (data != null ? _i2.Book.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Category?>()) {
      return (data != null ? _i3.Category.fromJson(data) : null) as T;
    }
    if (t == List<_i4.Book>) {
      return (data as List).map((e) => deserialize<_i4.Book>(e)).toList() as T;
    }
    if (t == List<_i5.Category>) {
      return (data as List).map((e) => deserialize<_i5.Category>(e)).toList()
          as T;
    }
    try {
      return _i6.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Book => 'Book',
      _i3.Category => 'Category',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('library.', '');
    }

    switch (data) {
      case _i2.Book():
        return 'Book';
      case _i3.Category():
        return 'Category';
    }
    className = _i6.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Book') {
      return deserialize<_i2.Book>(data['data']);
    }
    if (dataClassName == 'Category') {
      return deserialize<_i3.Category>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i6.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i6.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
