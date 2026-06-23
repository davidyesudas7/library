/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'book.dart' as _i2;
import 'package:library_server/src/generated/protocol.dart' as _i3;

abstract class DownloadedBook
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = DownloadedBookTable();

  static const db = DownloadedBookRepository._();

  @override
  int? id;

  String userName;

  String parish;

  String? email;

  String? phone;

  int bookId;

  _i2.Book? book;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DownloadedBook',
      if (id != null) 'id': id,
      'userName': userName,
      'parish': parish,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      'bookId': bookId,
      if (book != null) 'book': book?.toJsonForProtocol(),
    };
  }

  static DownloadedBookInclude include({_i2.BookInclude? book}) {
    return DownloadedBookInclude._(book: book);
  }

  static DownloadedBookIncludeList includeList({
    _i1.WhereExpressionBuilder<DownloadedBookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DownloadedBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DownloadedBookTable>? orderByList,
    DownloadedBookInclude? include,
  }) {
    return DownloadedBookIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DownloadedBook.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DownloadedBook.t),
      include: include,
    );
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

class DownloadedBookUpdateTable extends _i1.UpdateTable<DownloadedBookTable> {
  DownloadedBookUpdateTable(super.table);

  _i1.ColumnValue<String, String> userName(String value) => _i1.ColumnValue(
    table.userName,
    value,
  );

  _i1.ColumnValue<String, String> parish(String value) => _i1.ColumnValue(
    table.parish,
    value,
  );

  _i1.ColumnValue<String, String> email(String? value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<String, String> phone(String? value) => _i1.ColumnValue(
    table.phone,
    value,
  );

  _i1.ColumnValue<int, int> bookId(int value) => _i1.ColumnValue(
    table.bookId,
    value,
  );
}

class DownloadedBookTable extends _i1.Table<int?> {
  DownloadedBookTable({super.tableRelation})
    : super(tableName: 'downloaded_books') {
    updateTable = DownloadedBookUpdateTable(this);
    userName = _i1.ColumnString(
      'userName',
      this,
    );
    parish = _i1.ColumnString(
      'parish',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
  }

  late final DownloadedBookUpdateTable updateTable;

  late final _i1.ColumnString userName;

  late final _i1.ColumnString parish;

  late final _i1.ColumnString email;

  late final _i1.ColumnString phone;

  late final _i1.ColumnInt bookId;

  _i2.BookTable? _book;

  _i2.BookTable get book {
    if (_book != null) return _book!;
    _book = _i1.createRelationTable(
      relationFieldName: 'book',
      field: DownloadedBook.t.bookId,
      foreignField: _i2.Book.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.BookTable(tableRelation: foreignTableRelation),
    );
    return _book!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userName,
    parish,
    email,
    phone,
    bookId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'book') {
      return book;
    }
    return null;
  }
}

class DownloadedBookInclude extends _i1.IncludeObject {
  DownloadedBookInclude._({_i2.BookInclude? book}) {
    _book = book;
  }

  _i2.BookInclude? _book;

  @override
  Map<String, _i1.Include?> get includes => {'book': _book};

  @override
  _i1.Table<int?> get table => DownloadedBook.t;
}

class DownloadedBookIncludeList extends _i1.IncludeList {
  DownloadedBookIncludeList._({
    _i1.WhereExpressionBuilder<DownloadedBookTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DownloadedBook.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DownloadedBook.t;
}

class DownloadedBookRepository {
  const DownloadedBookRepository._();

  final attachRow = const DownloadedBookAttachRowRepository._();

  /// Returns a list of [DownloadedBook]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<DownloadedBook>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DownloadedBookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DownloadedBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DownloadedBookTable>? orderByList,
    _i1.Transaction? transaction,
    DownloadedBookInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DownloadedBook>(
      where: where?.call(DownloadedBook.t),
      orderBy: orderBy?.call(DownloadedBook.t),
      orderByList: orderByList?.call(DownloadedBook.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DownloadedBook] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<DownloadedBook?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DownloadedBookTable>? where,
    int? offset,
    _i1.OrderByBuilder<DownloadedBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DownloadedBookTable>? orderByList,
    _i1.Transaction? transaction,
    DownloadedBookInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DownloadedBook>(
      where: where?.call(DownloadedBook.t),
      orderBy: orderBy?.call(DownloadedBook.t),
      orderByList: orderByList?.call(DownloadedBook.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DownloadedBook] by its [id] or null if no such row exists.
  Future<DownloadedBook?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    DownloadedBookInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DownloadedBook>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DownloadedBook]s in the list and returns the inserted rows.
  ///
  /// The returned [DownloadedBook]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DownloadedBook>> insert(
    _i1.DatabaseSession session,
    List<DownloadedBook> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DownloadedBook>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DownloadedBook] and returns the inserted row.
  ///
  /// The returned [DownloadedBook] will have its `id` field set.
  Future<DownloadedBook> insertRow(
    _i1.DatabaseSession session,
    DownloadedBook row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DownloadedBook>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DownloadedBook]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DownloadedBook>> update(
    _i1.DatabaseSession session,
    List<DownloadedBook> rows, {
    _i1.ColumnSelections<DownloadedBookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DownloadedBook>(
      rows,
      columns: columns?.call(DownloadedBook.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DownloadedBook]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DownloadedBook> updateRow(
    _i1.DatabaseSession session,
    DownloadedBook row, {
    _i1.ColumnSelections<DownloadedBookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DownloadedBook>(
      row,
      columns: columns?.call(DownloadedBook.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DownloadedBook] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DownloadedBook?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DownloadedBookUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DownloadedBook>(
      id,
      columnValues: columnValues(DownloadedBook.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DownloadedBook]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DownloadedBook>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DownloadedBookUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DownloadedBookTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DownloadedBookTable>? orderBy,
    _i1.OrderByListBuilder<DownloadedBookTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DownloadedBook>(
      columnValues: columnValues(DownloadedBook.t.updateTable),
      where: where(DownloadedBook.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DownloadedBook.t),
      orderByList: orderByList?.call(DownloadedBook.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DownloadedBook]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DownloadedBook>> delete(
    _i1.DatabaseSession session,
    List<DownloadedBook> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DownloadedBook>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DownloadedBook].
  Future<DownloadedBook> deleteRow(
    _i1.DatabaseSession session,
    DownloadedBook row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DownloadedBook>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DownloadedBook>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DownloadedBookTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DownloadedBook>(
      where: where(DownloadedBook.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DownloadedBookTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DownloadedBook>(
      where: where?.call(DownloadedBook.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DownloadedBook] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DownloadedBookTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DownloadedBook>(
      where: where(DownloadedBook.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class DownloadedBookAttachRowRepository {
  const DownloadedBookAttachRowRepository._();

  /// Creates a relation between the given [DownloadedBook] and [Book]
  /// by setting the [DownloadedBook]'s foreign key `bookId` to refer to the [Book].
  Future<void> book(
    _i1.DatabaseSession session,
    DownloadedBook downloadedBook,
    _i2.Book book, {
    _i1.Transaction? transaction,
  }) async {
    if (downloadedBook.id == null) {
      throw ArgumentError.notNull('downloadedBook.id');
    }
    if (book.id == null) {
      throw ArgumentError.notNull('book.id');
    }

    var $downloadedBook = downloadedBook.copyWith(bookId: book.id);
    await session.db.updateRow<DownloadedBook>(
      $downloadedBook,
      columns: [DownloadedBook.t.bookId],
      transaction: transaction,
    );
  }
}
