import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_flutter/core/theme/app_colors.dart';
import 'package:library_flutter/features/admin/presentation/widgets/book_card.dart';
import 'package:library_flutter/features/library/presentation/providers/book_providers.dart';
import 'package:library_flutter/features/library/presentation/providers/category_providers.dart';
import 'package:library_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:library_flutter/core/network/serverpod_client.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int? _selectedCategoryId;
  bool _filterOnline = true;
  bool _filterOffline = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final booksAsync = ref.watch(
      filteredBooksProvider(
        categoryId: _selectedCategoryId,
        searchQuery: _searchQuery.isEmpty ? null : _searchQuery,
      ),
    );
    final categoriesAsync = ref.watch(categoriesProvider());
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    final user = ref.watch(authProvider);
    final isLoggedIn = user != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Academia Library',
          style: TextStyle(fontFamily: 'EB Garamond'),
        ),
        actions: [
          // if (!isLoggedIn) ...[
          //   TextButton(
          //     onPressed: () => context.go('/login'),
          //     child: const Text('Login / Register'),
          //   ),
          //   const SizedBox(width: 8),
          // ],
          if (isLoggedIn) ...[
            Center(
              child: Text(
                "Hi, User",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: () async {
                await ref.read(authProvider.notifier).logout();
                if (mounted) context.go('/');
              },
              child: const Text('Logout'),
            ),
            const SizedBox(width: 8),
          ],
          TextButton(
            onPressed: () => context.go('/admin'),
            child: const Text('Admin'),
          ),
          const SizedBox(width: 24),
        ],
      ),
      drawer: isDesktop ? null : Drawer(child: _buildSidebar(categoriesAsync)),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Sidebar (only on desktop)
          if (isDesktop) _buildSidebar(categoriesAsync),
          // Book Grid
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _searchQuery = value),
                    decoration: InputDecoration(
                      hintText: 'Search by title or author...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: AppColors.surfaceContainerLowest,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),

                booksAsync.when(
                  data: (books) {
                    var filteredBooks = books.where((book) {
                      if (!_filterOnline && book.isAvailableOnline)
                        return false;

                      bool matchesAvail = false;
                      if (_filterOnline && book.isAvailableOnline)
                        matchesAvail = true;
                      if (_filterOffline && book.isAvailableOffline)
                        matchesAvail = true;

                      if (!matchesAvail) return false;

                      return true;
                    }).toList();
                    // Determine columns based on width
                    final screenWidth = MediaQuery.of(context).size.width;
                    int columns = 4;
                    if (screenWidth < 600)
                      columns = 2;
                    else if (screenWidth < 900)
                      columns = 3;
                    if (books.isEmpty) {
                      return const Center(
                        child: Text('No books found.'),
                      );
                    }
                    return Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(24),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: filteredBooks.length,
                        itemBuilder: (context, index) {
                          final book = filteredBooks[index];
                          return BookCard(
                            book: book,
                            onTap: () {
                              if (book.id != null) {
                                context.push(
                                  '/book/${book.id}',
                                  extra: book,
                                );
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (err, _) => Center(child: Text('Error: \$err')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(AsyncValue categoriesAsync) {
    return Container(
      width: 280,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(right: BorderSide(color: AppColors.outlineVariant)),
      ),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Filter by Category',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildCategoryFilter(null, 'All Categories'),
          categoriesAsync.when(
            data: (categories) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: categories
                  .map<Widget>((cat) => _buildCategoryFilter(cat.id, cat.name))
                  .toList(),
            ),
            loading: () => const CircularProgressIndicator(),
            error: (_, __) => const Text('Error loading categories'),
          ),
          const SizedBox(height: 32),
          Text('Availability', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          CheckboxListTile(
            title: const Text('Digital (Online)'),
            value: _filterOnline,
            onChanged: (val) => setState(() => _filterOnline = val ?? true),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
          CheckboxListTile(
            title: const Text('Physical (Offline)'),
            value: _filterOffline,
            onChanged: (val) => setState(() => _filterOffline = val ?? true),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(int? id, String name) {
    final isSelected = _selectedCategoryId == id;
    return InkWell(
      onTap: () => setState(() => _selectedCategoryId = id),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.surfaceContainerHigh
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(
              Icons.bookmark,
              color: isSelected ? AppColors.primary : Colors.transparent,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? AppColors.primary
                    : AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
