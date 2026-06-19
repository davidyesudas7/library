import 'package:flutter/material.dart';
import 'package:library_flutter/core/theme/app_colors.dart';

class UserActionDialog extends StatefulWidget {
  final String title;
  final String actionLabel;
  final VoidCallback onActionSuccess;

  const UserActionDialog({
    super.key,
    required this.title,
    required this.actionLabel,
    required this.onActionSuccess,
  });

  @override
  State<UserActionDialog> createState() => _UserActionDialogState();
}

class _UserActionDialogState extends State<UserActionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _parishController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _parishController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      // Simulate network request for downloading/requesting
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.of(context).pop(); // Close the dialog
        widget.onActionSuccess(); // Trigger success callback
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Please provide your details to proceed.'),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _parishController,
                decoration: const InputDecoration(
                  labelText: 'Parish (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _submit,
          child: _isLoading 
            ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
            : Text(widget.actionLabel),
        ),
      ],
    );
  }
}
