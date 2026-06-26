// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(filteredBooks)
final filteredBooksProvider = FilteredBooksFamily._();

final class FilteredBooksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Book>>,
          List<Book>,
          FutureOr<List<Book>>
        >
    with $FutureModifier<List<Book>>, $FutureProvider<List<Book>> {
  FilteredBooksProvider._({
    required FilteredBooksFamily super.from,
    required ({int? categoryId, String? searchQuery}) super.argument,
  }) : super(
         retry: null,
         name: r'filteredBooksProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredBooksHash();

  @override
  String toString() {
    return r'filteredBooksProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Book>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Book>> create(Ref ref) {
    final argument = this.argument as ({int? categoryId, String? searchQuery});
    return filteredBooks(
      ref,
      categoryId: argument.categoryId,
      searchQuery: argument.searchQuery,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredBooksProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredBooksHash() => r'c1aacc710fd8d9ad0bc4aef47e0d51fc950db326';

final class FilteredBooksFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Book>>,
          ({int? categoryId, String? searchQuery})
        > {
  FilteredBooksFamily._()
    : super(
        retry: null,
        name: r'filteredBooksProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredBooksProvider call({int? categoryId, String? searchQuery}) =>
      FilteredBooksProvider._(
        argument: (categoryId: categoryId, searchQuery: searchQuery),
        from: this,
      );

  @override
  String toString() => r'filteredBooksProvider';
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

String _$bookNotifierHash() => r'd8029388a565b412dd62df82c38d2d7c8fbb1f58';

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
