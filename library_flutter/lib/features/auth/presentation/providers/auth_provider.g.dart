// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Auth)
final authProvider = AuthProvider._();

final class AuthProvider extends $NotifierProvider<Auth, AuthSuccess?> {
  AuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authHash();

  @$internal
  @override
  Auth create() => Auth();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthSuccess? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthSuccess?>(value),
    );
  }
}

String _$authHash() => r'ba6c0c67ec65614c027aa0dbb843bddc4d088ef9';

abstract class _$Auth extends $Notifier<AuthSuccess?> {
  AuthSuccess? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuthSuccess?, AuthSuccess?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthSuccess?, AuthSuccess?>,
              AuthSuccess?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
