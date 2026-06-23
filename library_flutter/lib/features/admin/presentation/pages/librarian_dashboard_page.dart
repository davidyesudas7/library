import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_flutter/core/theme/app_colors.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/admin_top_bar.dart';
import '../widgets/admin_footer.dart';
import '../widgets/book_card.dart';
import 'package:library_flutter/features/library/presentation/providers/book_providers.dart';
import 'package:library_flutter/features/library/presentation/providers/category_providers.dart';
import 'package:go_router/go_router.dart';
import 'package:library_flutter/core/network/serverpod_client.dart';

class LibrarianDashboardPage extends ConsumerWidget {
  const LibrarianDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(booksProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      body: Row(
        children: [
          const AdminSidebar(),
          Expanded(
            child: Column(
              children: [
                const AdminTopBar(title: 'Dashboard Overview'),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(48.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildWelcomeSection(context, booksAsync, categoriesAsync),
                          const SizedBox(height: 48),
                          _buildCurrentlyReading(context, booksAsync),
                          const SizedBox(height: 48),
                          _buildRecommended(context, booksAsync),
                        ],
                      ),
                    ),
                  ),
                ),
                const AdminFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, AsyncValue booksAsync, AsyncValue categoriesAsync) {
    int totalBooks = booksAsync.value?.length ?? 0;
    int totalCategories = categoriesAsync.value?.length ?? 0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back, Librarian.',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Here\'s what\'s happening in your library today.',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            _buildStatCard(context, 'Total Books', totalBooks.toString()),
            const SizedBox(width: 16),
            _buildStatCard(context, 'Categories', totalCategories.toString()),
            const SizedBox(width: 16),
            FutureBuilder<int>(
              future: client.downloadData.getTotalDownloadCount(),
              builder: (context, snapshot) {
                return _buildStatCard(
                  context, 
                  'Downloads', 
                  snapshot.hasData ? snapshot.data.toString() : '...'
                );
              },
            ),
          ],
        )
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border.all(color: AppColors.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentlyReading(BuildContext context, AsyncValue booksAsync) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recently Added Books',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 24),
        booksAsync.when(
          data: (books) {
            if (books.isEmpty) return const Text('No books in catalog.');
            final recentBooks = books.reversed.take(4).toList();
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 0.65,
              ),
              itemCount: recentBooks.length,
              itemBuilder: (context, index) {
                return BookCard(
                  book: recentBooks[index],
                  onTap: () {},
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Text('Error: $err', style: const TextStyle(color: AppColors.error)),
        ),
      ],
    );
  }

  Widget _buildRecommended(BuildContext context, AsyncValue booksAsync) {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Library Activity',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Review recent checkouts and monitor the status of physical archives. You have 12 pending requests.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.onPrimary.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: AppColors.onSecondary,
                  ),
                  child: const Text('VIEW ALL ACTIVITY'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 48),
          Expanded(
            child: booksAsync.when(
              data: (books) {
                if (books.isEmpty) return const SizedBox.shrink();
                final highlightBooks = books.take(2).toList();
                return Row(
                  children: highlightBooks.map<Widget>((book) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: book.imageUrl != null
                          ? Image.network(book.imageUrl!, fit: BoxFit.cover, height: 280)
                          : Container(height: 280, color: AppColors.surfaceContainerHigh),
                      ),
                    ),
                  )).toList(),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
