import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_client/library_client.dart';
import 'package:library_flutter/core/theme/app_colors.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/admin_top_bar.dart';
import '../widgets/admin_footer.dart';
import 'package:library_flutter/features/library/presentation/providers/category_providers.dart';
import 'package:library_flutter/features/library/presentation/providers/book_providers.dart';
import 'package:go_router/go_router.dart';

class ManageCategoryPage extends ConsumerStatefulWidget {
  final int categoryId;

  const ManageCategoryPage({super.key, required this.categoryId});

  @override
  ConsumerState<ManageCategoryPage> createState() => _ManageCategoryPageState();
}

class _ManageCategoryPageState extends ConsumerState<ManageCategoryPage> {
  bool _isAddBookOpen = false;
  String? _searchQuery;

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider());
    final category = categoriesAsync.value?.firstWhere(
      (c) => c.id == widget.categoryId,
      orElse: () => Category(name: 'Unknown Category'),
    );

    return Scaffold(
      body: Row(
        children: [
          const AdminSidebar(),
          Expanded(
            child: Column(
              children: [
                AdminTopBar(title: 'Manage ${category?.name ?? 'Category'}'),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(48.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader(context, category),
                              const SizedBox(height: 32),
                              _buildBooksTable(),
                            ],
                          ),
                        ),
                      ),
                      if (_isAddBookOpen) _buildInlineAddBook(),
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

  Widget _buildHeader(BuildContext context, Category? category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories / ${category?.name}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category?.name ?? 'Category',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            ElevatedButton.icon(
              onPressed: () {
                context.push('/admin/catalog/new');
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text('ADD NEW BOOK'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  log("the value is changed $value");
                  setState(() {
                    _searchQuery = value.isEmpty ? null : value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search books...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: AppColors.surfaceContainerLowest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: AppColors.outlineVariant,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'All', label: Text('All')),
                ButtonSegment(value: 'Digital', label: Text('Digital')),
                ButtonSegment(value: 'Physical', label: Text('Physical')),
              ],
              selected: const {'All'},
              onSelectionChanged: (set) {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBooksTable() {
    final booksAsync = ref.watch(
      filteredBooksProvider(
        categoryId: widget.categoryId,
        searchQuery: _searchQuery,
      ),
    );

    return booksAsync.when(
      data: (books) {
        if (books.isEmpty) {
          return const Center(child: Text('No books in this category.'));
        }
        log("the books are ${books.first.title}");
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.outlineVariant),
            borderRadius: BorderRadius.circular(8),
            color: AppColors.surfaceContainerLowest,
          ),
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(
              AppColors.surfaceContainerLow,
            ),
            dataRowMaxHeight: 80,
            columns: const [
              DataColumn(label: Text('COVER')),
              DataColumn(label: Text('TITLE')),
              DataColumn(label: Text('AUTHOR')),
              DataColumn(label: Text('AVAILABILITY')),
              DataColumn(label: Text('ACTIONS')),
            ],
            rows: books
                .map(
                  (book) => DataRow(
                    cells: [
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: book.imageUrl != null
                                ? Image.network(
                                    book.imageUrl!,
                                    width: 40,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 40,
                                    height: 60,
                                    color: AppColors.surfaceContainerHigh,
                                  ),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          book.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      DataCell(Text(book.author)),
                      DataCell(_buildAvailabilityBadge(book)),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined, size: 20),
                              onPressed: () {
                                context.push(
                                  '/admin/catalog/edit',
                                  extra: book,
                                );
                              },
                              color: AppColors.onSurfaceVariant,
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                size: 20,
                              ),
                              onPressed: () async {
                                await ref
                                    .read(bookProvider.notifier)
                                    .deleteBook(book);
                                ref.invalidate(
                                  filteredBooksProvider(
                                    categoryId: widget.categoryId,
                                    searchQuery: _searchQuery,
                                  ),
                                );
                              },
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
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildAvailabilityBadge(Book book) {
    if (book.isAvailableOnline && book.isAvailableOffline) {
      return const Text('Both');
    } else if (book.isAvailableOnline) {
      return _buildStatusBadge('ONLINE', true);
    } else {
      return _buildStatusBadge('OFFLINE', false);
    }
  }

  Widget _buildStatusBadge(String text, bool isOnline) {
    final color = isOnline
        ? AppColors.secondaryContainer
        : AppColors.primaryContainer;
    final textColor = isOnline
        ? AppColors.onSecondaryContainer
        : AppColors.onPrimaryContainer;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildInlineAddBook() {
    return Container(
      width: 400,
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border(
          left: BorderSide(color: AppColors.outlineVariant, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quick Add Book',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => _isAddBookOpen = false),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.outlineVariant),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Author',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Image URL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Implement quick add
                    },
                    child: const Text('ADD BOOK'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
