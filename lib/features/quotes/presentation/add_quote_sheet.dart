import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/data/auth_repository.dart';
import '../data/quotes_repository.dart';

class AddQuoteSheet extends ConsumerStatefulWidget {
  final String groupId;

  const AddQuoteSheet({super.key, required this.groupId});

  @override
  ConsumerState<AddQuoteSheet> createState() => _AddQuoteSheetState();
}

class _AddQuoteSheetState extends ConsumerState<AddQuoteSheet> {
  final _textController = TextEditingController();
  final _saidByController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _textController.dispose();
    _saidByController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final currentUser = ref.read(authRepositoryProvider).currentUser;
        if (currentUser == null) return;

        await ref
            .read(quotesRepositoryProvider)
            .addQuote(
              text: _textController.text.trim(),
              saidBy: _saidByController.text.trim(),
              groupId: widget.groupId,
              userId: currentUser.uid,
            );

        if (mounted) {
          context.pop(); // Sluit de sheet
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Fout bij toevoegen: $e')));
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Nieuwe Quote', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(
              controller: _textController,
              autofocus: true,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'De uitspraak',
                hintText: 'Wat is er gezegd?',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Vul een quote in' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _saidByController,
              decoration: const InputDecoration(
                labelText: 'Gezegd door',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Wie zei dit?' : null,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _isLoading ? null : _submit,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Toevoegen'),
            ),
          ],
        ),
      ),
    );
  }
}
