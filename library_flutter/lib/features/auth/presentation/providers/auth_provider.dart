import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'package:library_flutter/core/network/serverpod_client.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  UserInfo? build() {
    sessionManager.addListener(_onSessionChanged);
    ref.onDispose(() => sessionManager.removeListener(_onSessionChanged));
    return sessionManager.signedInUser;
  }

  void _onSessionChanged() {
    state = sessionManager.signedInUser;
  }

  Future<void> logout() async {
    await sessionManager.signOutDevice();
    // state will be automatically updated by _onSessionChanged
  }
}
