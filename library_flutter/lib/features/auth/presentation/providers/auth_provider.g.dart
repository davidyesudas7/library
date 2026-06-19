// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Auth)
final authProvider = AuthProvider._();

final class AuthProvider extends $NotifierProvider<Auth, UserInfo?> {
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
  Override overrideWithValue(UserInfo? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserInfo?>(value),
    );
  }
}

String _$authHash() => r'4c96b42e592d76c8fe7ee1efa684c048b1c4d3bc';

abstract class _$Auth extends $Notifier<UserInfo?> {
  UserInfo? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<UserInfo?, UserInfo?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserInfo?, UserInfo?>,
              UserInfo?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
