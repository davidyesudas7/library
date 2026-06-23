import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:library_client/library_client.dart';

late Client client;

Future<void> initializeServerpodClient() async {
  const apiUrl = String.fromEnvironment(
    'API_URL', 
    defaultValue: 'http://localhost:8080/',
  );

  client = Client(apiUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();

  client.auth.initialize();
}
