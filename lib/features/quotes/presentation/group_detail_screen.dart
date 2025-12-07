import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/quotes_repository.dart';
import 'add_quote_sheet.dart';

class GroupDetailScreen extends ConsumerWidget {
  final String groupId;

  const GroupDetailScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotesAsync = ref.watch(groupQuotesProvider(groupId));

    return Scaffold(
      appBar: AppBar(title: const Text('Quotes')),
      body: quotesAsync.when(
        data: (quotes) => ListView.builder(
          itemCount: quotes.length,
          itemBuilder: (context, index) {
            final quote = quotes[index];
            return ListTile(
              title: Text('"${quote.text}"'),
              subtitle: Text('- ${quote.saidBy}'),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Fout: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (context) => AddQuoteSheet(groupId: groupId),
          );
        },
        child: const Icon(Icons.add_comment),
      ),
    );
  }
}
