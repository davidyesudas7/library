import 'package:flutter/material.dart';
import 'package:library_flutter/core/theme/app_colors.dart';

class AdminTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AdminTopBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.outlineVariant, width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.onSurfaceVariant,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none, color: AppColors.onSurfaceVariant),
                  onPressed: () {},
                ),
                const SizedBox(width: 16),
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.primaryContainer,
                  child: Text('A', style: TextStyle(color: AppColors.onPrimaryContainer, fontSize: 14)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}
