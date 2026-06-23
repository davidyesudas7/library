import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:library_flutter/core/network/serverpod_client.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  AuthSuccess? build() {
    client.auth.authInfoListenable.addListener(_onAuthStateChanged);
    ref.onDispose(() => client.auth.authInfoListenable.removeListener(_onAuthStateChanged));
    return client.auth.authInfo;
  }

  void _onAuthStateChanged() {
    state = client.auth.authInfo;
  }

  Future<void> logout() async {
    try {
      await client.auth.signOutDevice();
    } catch (e) {
      log('Signout server error: $e');
    }
    state = null;
  }
}
