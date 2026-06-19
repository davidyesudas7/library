import 'package:flutter/material.dart';
import 'package:library_flutter/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:library_flutter/core/network/serverpod_client.dart';

class UserLoginPage extends StatelessWidget {
  const UserLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(48),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sign In or Register',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Create an account to save books and request offline reading.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: 32),
              SignInWithEmailButton(
                caller: client.modules.auth,
                onSignedIn: () {
                  context.go('/');
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.go('/'),
                child: const Text('Back to Library'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
