// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_remote_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookRemoteDataSource)
final bookRemoteDataSourceProvider = BookRemoteDataSourceProvider._();

final class BookRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          BookRemoteDataSource,
          BookRemoteDataSource,
          BookRemoteDataSource
        >
    with $Provider<BookRemoteDataSource> {
  BookRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<BookRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BookRemoteDataSource create(Ref ref) {
    return bookRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookRemoteDataSource>(value),
    );
  }
}

String _$bookRemoteDataSourceHash() =>
    r'9c863a731bc30e3402646432cee830bf564deb57';
