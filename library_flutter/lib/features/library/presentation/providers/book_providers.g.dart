// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(books)
final booksProvider = BooksProvider._();

final class BooksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Book>>,
          List<Book>,
          FutureOr<List<Book>>
        >
    with $FutureModifier<List<Book>>, $FutureProvider<List<Book>> {
  BooksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'booksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$booksHash();

  @$internal
  @override
  $FutureProviderElement<List<Book>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Book>> create(Ref ref) {
    return books(ref);
  }
}

String _$booksHash() => r'cbf213432d3d1cc19543bc858d278da65ca60a5e';

@ProviderFor(booksByCategory)
final booksByCategoryProvider = BooksByCategoryFamily._();

final class BooksByCategoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Book>>,
          List<Book>,
          FutureOr<List<Book>>
        >
    with $FutureModifier<List<Book>>, $FutureProvider<List<Book>> {
  BooksByCategoryProvider._({
    required BooksByCategoryFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'booksByCategoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$booksByCategoryHash();

  @override
  String toString() {
    return r'booksByCategoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Book>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Book>> create(Ref ref) {
    final argument = this.argument as int;
    return booksByCategory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BooksByCategoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$booksByCategoryHash() => r'cc1dabab38a83e85931d68c949a7d43fb630e298';

final class BooksByCategoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Book>>, int> {
  BooksByCategoryFamily._()
    : super(
        retry: null,
        name: r'booksByCategoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BooksByCategoryProvider call(int categoryId) =>
      BooksByCategoryProvider._(argument: categoryId, from: this);

  @override
  String toString() => r'booksByCategoryProvider';
}

@ProviderFor(BookNotifier)
final bookProvider = BookNotifierProvider._();

final class BookNotifierProvider
    extends $AsyncNotifierProvider<BookNotifier, void> {
  BookNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookNotifierHash();

  @$internal
  @override
  BookNotifier create() => BookNotifier();
}

String _$bookNotifierHash() => r'2f5026f83b0b6b808175e0c6b1e8edf1d6cddcb8';

abstract class _$BookNotifier extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
