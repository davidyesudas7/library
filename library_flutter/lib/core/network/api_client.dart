import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_client/library_client.dart';

part 'api_client.g.dart';

@riverpod
Client apiClient(Ref ref) {
  return Client('http://localhost:8080/');
}
