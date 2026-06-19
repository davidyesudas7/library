import 'package:flutter/material.dart';
import 'package:library_flutter/core/theme/app_colors.dart';

class AdminFooter extends StatelessWidget {
  const AdminFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 48),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.outlineVariant, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '© 2026 Academia Library',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          Row(
            children: [
              _buildFooterLink(context, 'Support'),
              const SizedBox(width: 24),
              _buildFooterLink(context, 'Documentation'),
              const SizedBox(width: 24),
              _buildFooterLink(context, 'Privacy Policy'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFooterLink(BuildContext context, String text) {
    return InkWell(
      onTap: () {},
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
