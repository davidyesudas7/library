import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_flutter/core/theme/app_colors.dart';
import 'package:library_flutter/features/library/presentation/providers/category_providers.dart';

class AdminSidebar extends ConsumerWidget {
  const AdminSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Container(
      width: 280,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          right: BorderSide(color: AppColors.outlineVariant, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                const Icon(Icons.menu_book, color: AppColors.primary),
                const SizedBox(width: 12),
                Text(
                  'Library Admin',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontFamily: 'EB Garamond', // Enforcing garamond for logo
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.outlineVariant),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _SidebarItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  onTap: () => context.go('/admin'),
                ),
                _SidebarItem(
                  icon: Icons.inventory_2,
                  title: 'Manage Catalog',
                  onTap: () => context.go('/admin/catalog'),
                ),
                _SidebarItem(
                  icon: Icons.add_circle,
                  title: 'Add New Book',
                  onTap: () => context.go('/admin/catalog/new'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Text('CATEGORIES', style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: AppColors.onSurfaceVariant,
                  )),
                ),
                categoriesAsync.when(
                  data: (categories) => Column(
                    children: categories.map((cat) => _SidebarItem(
                      icon: Icons.bookmark_border,
                      title: cat.name,
                      onTap: () => context.go('/admin/category/${cat.id}'),
                    )).toList(),
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (_, __) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text('Failed to load categories', style: TextStyle(color: AppColors.error)),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.outlineVariant),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                _SidebarItem(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {},
                ),
                _SidebarItem(
                  icon: Icons.logout,
                  title: 'Sign Out',
                  onTap: () => context.go('/login'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.onSurfaceVariant),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.onSurfaceVariant,
      )),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      onTap: onTap,
      hoverColor: AppColors.surfaceContainerHigh,
    );
  }
}
