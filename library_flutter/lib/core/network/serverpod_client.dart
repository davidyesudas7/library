import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:library_client/library_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

late SessionManager sessionManager;
late Client client;

Future<void> initializeServerpodClient() async {
  client = Client(
    'http://localhost:8080/',
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();

  sessionManager = SessionManager(caller: client.modules.auth);
  await sessionManager.initialize();
}
