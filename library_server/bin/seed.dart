import 'package:library_server/src/endpoints/seed_endpoint.dart';
import 'package:library_server/src/generated/endpoints.dart';
import 'package:library_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

void main(List<String> args) async {
  final serverpod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );

  await serverpod.start();

  final session = await serverpod.createSession(enableLogging: true);
  try {
    print('Seeding database...');
    final result = await SeedEndpoint().seedDatabase(session);
    print('Seed result: \$result');
  } catch (e) {
    print('Failed to seed: \$e');
  } finally {
    await session.close();
  }
}
