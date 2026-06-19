import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_client/library_client.dart';

final apiClientProvider = Provider<Client>((ref) {
  return Client('http://localhost:8080/');
});
