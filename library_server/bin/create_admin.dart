import 'package:library_server/src/generated/protocol.dart' as app;
import 'package:library_server/src/generated/endpoints.dart' as app;
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

void main() async {
  final pod = Serverpod(
    ['--role', 'maintenance'],
    app.Protocol(),
    app.Endpoints(),
  );

  // Auth services must be initialized to use IDP mechanisms
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode:
            (
              s, {
              required email,
              required accountRequestId,
              required verificationCode,
              required transaction,
            }) {},
        sendPasswordResetVerificationCode:
            (
              s, {
              required email,
              required passwordResetRequestId,
              required verificationCode,
              required transaction,
            }) {},
      ),
    ],
  );

  await pod.start();

  final session = await pod.createSession(enableLogging: true);

  const email = 'admin@library.com';
  const password = 'password123';
  const userName = 'Administrator';

  try {
    session.log('Checking if admin user exists...');

    var emailAccount = await EmailAccount.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
      include: EmailAccount.include(authUser: AuthUser.include()),
    );

    final passwordHash = await AuthServices.instance.emailIdp.utils.hashUtil
        .createHashFromString(secret: password);

    if (emailAccount == null) {
      session.log('Admin user not found. Creating...');

      // Creating auth user
      var authUser = AuthUser(
        createdAt: DateTime.now().toUtc(),
        scopeNames: {Scope.admin.name!},
        blocked: false,
      );

      authUser = await AuthUser.db.insertRow(session, authUser);

      // Creating email account
      final newEmailAccount = EmailAccount(
        authUserId: authUser.id!,
        email: email,
        passwordHash: passwordHash,
      );

      await EmailAccount.db.insertRow(session, newEmailAccount);

      session.log('✅ Admin user created successfully with Scope.admin!');
      session.log('Email: $email');
      session.log('Password: $password');
    } else {
      session.log('⚠️ Admin user already exists! Updating password hash...');
      emailAccount.passwordHash = passwordHash;
      await EmailAccount.db.updateRow(session, emailAccount);
      session.log('Email: $email');
      session.log('Password: $password');

      // Ensure scope is granted even if user exists
      var authUser = emailAccount.authUser;
      if (authUser != null &&
          !authUser.scopeNames.contains(Scope.admin.name!)) {
        authUser.scopeNames.add(Scope.admin.name!);
        await AuthUser.db.updateRow(session, authUser);
        session.log('✅ Ensured Scope.admin is granted.');
      }
    }
  } catch (e) {
    session.log('❌ Error: $e');
  } finally {
    await session.close();
    await pod.shutdown();
  }
}
