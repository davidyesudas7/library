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

class AddNewBookPage extends ConsumerStatefulWidget {
  final Book? existingBook;

  const AddNewBookPage({super.key, this.existingBook});

  @override
  ConsumerState<AddNewBookPage> createState() => _AddNewBookPageState();
}

class _AddNewBookPageState extends ConsumerState<AddNewBookPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;
  late TextEditingController _pdfUrlController;

  late bool _isOnline;
  late bool _isOffline;
  int? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    final book = widget.existingBook;
    _titleController = TextEditingController(text: book?.title ?? '');
    _authorController = TextEditingController(text: book?.author ?? '');
    _descriptionController = TextEditingController(
      text: book?.description ?? '',
    );
    _imageUrlController = TextEditingController(text: book?.imageUrl ?? '');
    _pdfUrlController = TextEditingController(text: book?.pdfUrl ?? '');
    _isOnline = book?.isAvailableOnline ?? true;
    _isOffline = book?.isAvailableOffline ?? false;
    _selectedCategoryId = book?.categoryId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate() && _selectedCategoryId != null) {
      final book = Book(
        id: widget.existingBook?.id,
        title: _titleController.text,
        author: _authorController.text,
        description: _descriptionController.text,
        imageUrl: _imageUrlController.text.isNotEmpty
            ? _imageUrlController.text
            : null,
        isAvailableOnline: _isOnline,
        isAvailableOffline: _isOffline,
        categoryId: _selectedCategoryId!,
        pdfUrl: _pdfUrlController.text.isNotEmpty
            ? _pdfUrlController.text
            : null,
      );

      if (widget.existingBook != null) {
        await ref.read(bookNotifierProvider.notifier).updateBook(book);
      } else {
        await ref.read(bookNotifierProvider.notifier).createBook(book);
      }

      if (mounted) {
        context.pop();
      }
    }
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
                AdminTopBar(
                  title: widget.existingBook != null
                      ? 'Edit Book'
                      : 'Add New Book',
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(48.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.existingBook != null
                                  ? 'Edit Book'
                                  : 'Add New Book to Catalog',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 48),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: _buildLeftColumn(),
                                ),
                                const SizedBox(width: 48),
                                Expanded(
                                  flex: 2,
                                  child: _buildRightColumn(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 48),
                            const Divider(
                              height: 1,
                              color: AppColors.outlineVariant,
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                  onPressed: () => context.pop(),
                                  child: const Text('CANCEL'),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                  onPressed: _submit,
                                  child: Text(
                                    widget.existingBook != null
                                        ? 'SAVE CHANGES'
                                        : 'ADD TO CATALOG',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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

  Widget _buildLeftColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 0.66, // 2:3
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              border: Border.all(color: AppColors.outlineVariant),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 48,
                    color: AppColors.outlineVariant,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Upload Cover Image',
                    style: TextStyle(color: AppColors.onSurfaceVariant),
                  ),
                  Text(
                    'PNG, JPG up to 5MB',
                    style: TextStyle(fontSize: 12, color: AppColors.outline),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: _imageUrlController,
          decoration: const InputDecoration(
            labelText: 'Or image URL',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'Availability',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        CheckboxListTile(
          title: const Text('Available Online (Digital)'),
          value: _isOnline,
          onChanged: (val) => setState(() => _isOnline = val ?? false),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        ),
        CheckboxListTile(
          title: const Text('Available Offline (Physical)'),
          value: _isOffline,
          onChanged: (val) => setState(() => _isOffline = val ?? false),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildRightColumn() {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Metadata',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: 'Book Title *',
            border: OutlineInputBorder(),
          ),
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: _authorController,
          decoration: const InputDecoration(
            labelText: 'Author *',
            border: OutlineInputBorder(),
          ),
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 24),
        categoriesAsync.when(
          data: (categories) => DropdownButtonFormField<int>(
            decoration: const InputDecoration(
              labelText: 'Category *',
              border: OutlineInputBorder(),
            ),
            value: _selectedCategoryId,
            items: categories
                .map(
                  (cat) => DropdownMenuItem(
                    value: cat.id,
                    child: Text(cat.name),
                  ),
                )
                .toList(),
            onChanged: (val) => setState(() => _selectedCategoryId = val),
            validator: (val) => val == null ? 'Required' : null,
          ),
          loading: () => const CircularProgressIndicator(),
          error: (_, __) => const Text('Error loading categories'),
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
            alignLabelWithHint: true,
          ),
          maxLines: 6,
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: _pdfUrlController,
          decoration: const InputDecoration(
            labelText: 'PDF URL',
            border: OutlineInputBorder(),
            alignLabelWithHint: true,
          ),
          maxLines: 1,
        ),
      ],
    );
  }
}
