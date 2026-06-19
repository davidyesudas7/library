import 'package:library_server/src/generated/protocol.dart';
import 'package:library_server/src/generated/endpoints.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

void main() async {
  final pod = Serverpod(['--role', 'maintenance'], Protocol(), Endpoints());
  await pod.start();

  final session = await pod.createSession(enableLogging: true);

  const email = 'admin@library.com';
  const password = 'password123';
  const userName = 'Administrator';

  try {
    session.log('Checking if admin user exists...');
    
    var userInfo = await auth.Users.findUserByEmail(session, email);
    
    if (userInfo == null) {
      session.log('Admin user not found. Creating...');
      
      userInfo = await auth.Emails.createUser(
        session,
        userName,
        email,
        password,
      );

      if (userInfo != null) {
        session.log('✅ Admin user created successfully!');
        session.log('Email: \$email');
        session.log('Password: \$password');
      } else {
        session.log('❌ Failed to create admin user.');
      }
    } else {
      session.log('⚠️ Admin user already exists!');
      session.log('Email: \$email');
    }
  } catch (e) {
    session.log('❌ Error: \$e');
  } finally {
    await session.close();
    await pod.shutdown();
  }
}
