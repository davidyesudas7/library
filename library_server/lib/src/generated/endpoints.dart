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
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/book_endpoint.dart' as _i2;
import '../endpoints/category_endpoint.dart' as _i3;
import '../endpoints/seed_endpoint.dart' as _i4;
import 'package:library_server/src/generated/book.dart' as _i5;
import 'package:library_server/src/generated/category.dart' as _i6;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i7;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'book': _i2.BookEndpoint()
        ..initialize(
          server,
          'book',
          null,
        ),
      'category': _i3.CategoryEndpoint()
        ..initialize(
          server,
          'category',
          null,
        ),
      'seed': _i4.SeedEndpoint()
        ..initialize(
          server,
          'seed',
          null,
        ),
    };
    connectors['book'] = _i1.EndpointConnector(
      name: 'book',
      endpoint: endpoints['book']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['book'] as _i2.BookEndpoint).getAll(session),
        ),
        'getByCategory': _i1.MethodConnector(
          name: 'getByCategory',
          params: {
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['book'] as _i2.BookEndpoint).getByCategory(
                session,
                params['categoryId'],
              ),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'book': _i1.ParameterDescription(
              name: 'book',
              type: _i1.getType<_i5.Book>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['book'] as _i2.BookEndpoint).create(
                session,
                params['book'],
              ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'book': _i1.ParameterDescription(
              name: 'book',
              type: _i1.getType<_i5.Book>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['book'] as _i2.BookEndpoint).update(
                session,
                params['book'],
              ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'book': _i1.ParameterDescription(
              name: 'book',
              type: _i1.getType<_i5.Book>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['book'] as _i2.BookEndpoint).delete(
                session,
                params['book'],
              ),
        ),
      },
    );
    connectors['category'] = _i1.EndpointConnector(
      name: 'category',
      endpoint: endpoints['category']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['category'] as _i3.CategoryEndpoint).getAll(
                session,
              ),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i6.Category>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['category'] as _i3.CategoryEndpoint).create(
                session,
                params['category'],
              ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i6.Category>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['category'] as _i3.CategoryEndpoint).update(
                session,
                params['category'],
              ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i6.Category>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['category'] as _i3.CategoryEndpoint).delete(
                session,
                params['category'],
              ),
        ),
      },
    );
    connectors['seed'] = _i1.EndpointConnector(
      name: 'seed',
      endpoint: endpoints['seed']!,
      methodConnectors: {
        'seedDatabase': _i1.MethodConnector(
          name: 'seedDatabase',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['seed'] as _i4.SeedEndpoint).seedDatabase(session),
        ),
      },
    );
    modules['serverpod_auth'] = _i7.Endpoints()..initializeEndpoints(server);
  }
}
