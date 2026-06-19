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
import 'dart:async' as _i2;
import 'package:library_client/src/protocol/book.dart' as _i3;
import 'package:library_client/src/protocol/category.dart' as _i4;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i5;
import 'protocol.dart' as _i6;

/// {@category Endpoint}
class EndpointBook extends _i1.EndpointRef {
  EndpointBook(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'book';

  _i2.Future<List<_i3.Book>> getAll() =>
      caller.callServerEndpoint<List<_i3.Book>>(
        'book',
        'getAll',
        {},
      );

  _i2.Future<List<_i3.Book>> getByCategory(int categoryId) =>
      caller.callServerEndpoint<List<_i3.Book>>(
        'book',
        'getByCategory',
        {'categoryId': categoryId},
      );

  _i2.Future<_i3.Book> create(_i3.Book book) =>
      caller.callServerEndpoint<_i3.Book>(
        'book',
        'create',
        {'book': book},
      );

  _i2.Future<_i3.Book> update(_i3.Book book) =>
      caller.callServerEndpoint<_i3.Book>(
        'book',
        'update',
        {'book': book},
      );

  _i2.Future<_i3.Book> delete(_i3.Book book) =>
      caller.callServerEndpoint<_i3.Book>(
        'book',
        'delete',
        {'book': book},
      );
}

/// {@category Endpoint}
class EndpointCategory extends _i1.EndpointRef {
  EndpointCategory(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'category';

  _i2.Future<List<_i4.Category>> getAll() =>
      caller.callServerEndpoint<List<_i4.Category>>(
        'category',
        'getAll',
        {},
      );

  _i2.Future<_i4.Category> create(_i4.Category category) =>
      caller.callServerEndpoint<_i4.Category>(
        'category',
        'create',
        {'category': category},
      );

  _i2.Future<_i4.Category> update(_i4.Category category) =>
      caller.callServerEndpoint<_i4.Category>(
        'category',
        'update',
        {'category': category},
      );

  _i2.Future<_i4.Category> delete(_i4.Category category) =>
      caller.callServerEndpoint<_i4.Category>(
        'category',
        'delete',
        {'category': category},
      );
}

/// {@category Endpoint}
class EndpointSeed extends _i1.EndpointRef {
  EndpointSeed(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'seed';

  _i2.Future<bool> seedDatabase() => caller.callServerEndpoint<bool>(
    'seed',
    'seedDatabase',
    {},
  );
}

class Modules {
  Modules(Client client) {
    auth = _i5.Caller(client);
  }

  late final _i5.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i6.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    book = EndpointBook(this);
    category = EndpointCategory(this);
    seed = EndpointSeed(this);
    modules = Modules(this);
  }

  late final EndpointBook book;

  late final EndpointCategory category;

  late final EndpointSeed seed;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'book': book,
    'category': category,
    'seed': seed,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'auth': modules.auth,
  };
}
