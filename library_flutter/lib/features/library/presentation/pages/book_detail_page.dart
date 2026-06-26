import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:library_flutter/core/network/serverpod_client.dart';
import 'package:library_flutter/core/theme/app_colors.dart';
import 'package:library_flutter/features/library/presentation/providers/book_providers.dart';
import 'package:library_flutter/features/library/presentation/providers/category_providers.dart';
import 'package:library_flutter/features/library/presentation/widgets/user_action_dialog.dart';
import 'package:library_client/library_client.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailPage extends ConsumerWidget {
  final int bookId;
  final Book? book;

  const BookDetailPage({super.key, required this.bookId, this.book});

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.secondary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleDownload(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => UserActionDialog(
        title: 'Download PDF',
        actionLabel: 'DOWNLOAD',
        onActionSuccess: (name, parish, email, phone) async {
          if (book?.pdfUrl == null || (book?.pdfUrl?.isEmpty ?? true)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('PDF URL is not available'),
              ),
            );
            return;
          }

          try {
            // Save download request to backend
            await client.downloadData.saveDownloadRequest(
              DownloadedBook(
                userName: name,
                parish: parish,
                email: email.isNotEmpty ? email : null,
                phone: phone.isNotEmpty ? phone : null,
                bookId: book!.id!,
              ),
            );
          } catch (e) {
            debugPrint('Error saving download request: $e');
            // We still proceed with the download even if tracking fails.
          }

          final uri = Uri.parse(book!.pdfUrl!);

          try {
            final launched = await launchUrl(
              uri,
              mode: LaunchMode.platformDefault,
            );

            if (!launched) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Could not open the PDF'),
                ),
              );
            }
          } catch (e) {
            debugPrint('Error launching URL: $e');

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to open PDF: $e'),
              ),
            );
          }
        },
      ),
    );
  }

  void _handleRequest(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => UserActionDialog(
        title: 'Request Physical Copy',
        actionLabel: 'REQUEST BOOK',
        onActionSuccess: (name, parish, email, phone) {
          _showSuccessSnackBar(
            context,
            'Your request has been sent to the librarian.',
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(filteredBooksProvider());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Details',
          style: TextStyle(fontFamily: 'EB Garamond'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: book != null
          ? _buildBookContent(context, ref, book!)
          : booksAsync.when(
              data: (books) {
                final fallbackBook = books
                    .where((b) => b.id == bookId)
                    .firstOrNull;
                if (fallbackBook == null) {
                  final availableIds = books.map((b) => b.id).toList();
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        'Book not found (Requested ID: \$bookId, Type: \${bookId.runtimeType}).\nAvailable IDs: \$availableIds\nTotal Books: \${books.length}',
                      ),
                    ),
                  );
                }
                return _buildBookContent(context, ref, fallbackBook);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) =>
                  Center(child: Text('Error loading book: \$err')),
            ),
    );
  }

  Widget _buildBookContent(BuildContext context, WidgetRef ref, Book book) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    // Image Widget
    final imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: book.imageUrl != null
          ? Image.network(book.imageUrl!, fit: BoxFit.cover)
          : Container(
              height: 400,
              color: AppColors.surfaceContainerHigh,
              child: const Center(
                child: Icon(
                  Icons.book,
                  size: 64,
                  color: AppColors.outlineVariant,
                ),
              ),
            ),
    );

    // Details Widget
    final detailsWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryLabel(ref, book.categoryId),
        const SizedBox(height: 16),
        Text(
          book.title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontFamily: 'EB Garamond',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              book.author,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            if (book.id != null)
              FutureBuilder<int>(
                future: client.downloadData.getBookDownloadCount(book.id!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const SizedBox.shrink();
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.download,
                          size: 16,
                          color: AppColors.onSecondaryContainer,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${snapshot.data} Downloads',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          'About this book',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          book.description ?? 'No description available for this book.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.6,
          ),
        ),
        const SizedBox(height: 48),
        const Divider(color: AppColors.outlineVariant),
        const SizedBox(height: 32),
        // Action Buttons
        if (book.isAvailableOnline) ...[
          Row(
            children: [
              const Icon(Icons.computer, color: AppColors.primary),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Digital Edition',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Available for immediate download as PDF.',
                      style: TextStyle(color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _handleDownload(context),
                icon: const Icon(Icons.download),
                label: const Text('DOWNLOAD PDF'),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
        if (book.isAvailableOffline) ...[
          Row(
            children: [
              const Icon(Icons.library_books, color: AppColors.primary),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Physical Edition',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Available at the main library archive.',
                      style: TextStyle(color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => _handleRequest(context),
                icon: const Icon(Icons.assignment),
                label: const Text('REQUEST COPY'),
              ),
            ],
          ),
        ],
      ],
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: imageWidget),
                    const SizedBox(width: 48),
                    Expanded(flex: 3, child: detailsWidget),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    imageWidget,
                    const SizedBox(height: 32),
                    detailsWidget,
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildCategoryLabel(WidgetRef ref, int categoryId) {
    final categoriesAsync = ref.watch(categoriesProvider());
    return categoriesAsync.when(
      data: (categories) {
        final category = categories.firstWhere(
          (c) => c.id == categoryId,
          orElse: () => Category(name: 'Unknown'),
        );
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            category.name.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        );
      },
      loading: () => const SizedBox(
        width: 50,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
