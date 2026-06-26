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
import 'package:library_client/library_client.dart';

class ManageCatalogPage extends ConsumerStatefulWidget {
  const ManageCatalogPage({super.key});

  @override
  ConsumerState<ManageCatalogPage> createState() => _ManageCatalogPageState();
}

class _ManageCatalogPageState extends ConsumerState<ManageCatalogPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _searchQuery;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _searchQuery = null;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const AdminSidebar(),
          Expanded(
            child: Column(
              children: [
                const AdminTopBar(title: 'Manage Catalog'),
                Expanded(
                  child: Column(
                    children: [
                      _buildHeader(context),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildCategoriesTab(),
                            _buildBooksTab(),
                          ],
                        ),
                      ),
                    ],
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(48, 48, 48, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Catalog Management',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _showCategoryDialog(),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('ADD CATEGORY'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () => context.go('/admin/catalog/new'),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('ADD NEW BOOK'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.isEmpty ? null : value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search catalog...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: AppColors.surfaceContainerLowest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                        color: AppColors.outlineVariant,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                        color: AppColors.outlineVariant,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.onSurfaceVariant,
                indicatorColor: AppColors.primary,
                tabs: const [
                  Tab(text: 'Categories'),
                  Tab(text: 'Books'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(height: 1, color: AppColors.outlineVariant),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    final categoriesAsync = ref.watch(categoriesProvider(query: _searchQuery));
    return categoriesAsync.when(
      data: (categories) {
        if (categories.isEmpty) {
          return const Center(child: Text('No categories found.'));
        }
        return ListView(
          padding: const EdgeInsets.all(48),
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.outlineVariant),
                borderRadius: BorderRadius.circular(8),
                color: AppColors.surfaceContainerLowest,
              ),
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(
                  AppColors.surfaceContainerLow,
                ),
                columns: const [
                  DataColumn(label: Text('CATEGORY NAME')),
                  DataColumn(label: Text('ITEMS')),
                  DataColumn(label: Text('STATUS')),
                  DataColumn(label: Text('ACTIONS')),
                ],
                rows: categories
                    .map(
                      (cat) => DataRow(
                        cells: [
                          DataCell(
                            Text(
                              cat.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const DataCell(
                            Text('N/A'),
                          ), // Mock count since we don't fetch relation count easily yet
                          DataCell(_buildStatusBadge('Active', true)),
                          DataCell(
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                    size: 20,
                                  ),
                                  onPressed: () => _showCategoryDialog(cat),
                                  color: AppColors.onSurfaceVariant,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    size: 20,
                                  ),
                                  onPressed: () => _deleteCategory(cat),
                                  color: AppColors.error,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: \$e')),
    );
  }

  void _showCategoryDialog([Category? existingCategory]) {
    final isEditing = existingCategory != null;
    final controller = TextEditingController(
      text: existingCategory?.name ?? '',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Category' : 'Add Category'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Category Name',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = controller.text.trim();
                if (name.isNotEmpty) {
                  if (isEditing) {
                    final updated = existingCategory.copyWith(name: name);
                    await ref
                        .read(categoryProvider.notifier)
                        .updateCategory(updated);
                  } else {
                    final newCategory = Category(name: name);
                    await ref
                        .read(categoryProvider.notifier)
                        .createCategory(newCategory);
                  }
                  if (context.mounted) {
                    context.pop();
                  }
                }
              },
              child: Text(isEditing ? 'SAVE' : 'ADD'),
            ),
          ],
        );
      },
    );
  }

  void _deleteCategory(Category category) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Category'),
          content: Text(
            'Are you sure you want to delete the category "\${category.name}"? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                await ref
                    .read(categoryProvider.notifier)
                    .deleteCategory(category);
                if (context.mounted) {
                  context.pop();
                }
              },
              child: const Text('DELETE'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBooksTab() {
    final booksAsync = ref.watch(
      filteredBooksProvider(searchQuery: _searchQuery),
    );
    return booksAsync.when(
      data: (books) {
        if (books.isEmpty) {
          return const Center(child: Text('No books found.'));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(48),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 0.65,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return BookCard(
              book: book,
              onTap: () {},
              onEdit: () => context.push('/admin/catalog/edit', extra: book),
              onDelete: () => _deleteBook(book),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  void _deleteBook(Book book) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Book'),
          content: Text(
            'Are you sure you want to delete the book "${book.title}"? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                ref.read(bookProvider.notifier).deleteBook(book);
                Navigator.pop(context);
              },
              child: const Text('DELETE'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatusBadge(String text, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.secondaryContainer
            : AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: isActive
              ? AppColors.onSecondaryContainer
              : AppColors.onSurfaceVariant,
        ),
      ),
    );
  }
}
