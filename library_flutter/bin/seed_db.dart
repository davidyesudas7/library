import 'package:library_client/library_client.dart';

void main() async {
  final client = Client('http://localhost:8080/');
  
  try {
    print('Calling seed database endpoint...');
    final result = await client.seed.seedDatabase();
    if (result) {
      print('Database seeded successfully!');
    } else {
      print('Database seeding failed or already seeded.');
    }
  } catch (e) {
    print('Failed to call seed endpoint: $e');
  } finally {
    client.close();
  }
}
