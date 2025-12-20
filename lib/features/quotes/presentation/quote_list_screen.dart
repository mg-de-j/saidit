import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../auth/data/auth_repository.dart';
import '../data/quotes_repository.dart';

class QuoteListScreen extends ConsumerWidget {
  final String groupId;

  const QuoteListScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotesAsync = ref.watch(groupQuotesProvider(groupId));
    final userId = ref.watch(authRepositoryProvider).currentUser?.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('Alle Quotes')),
      body: quotesAsync.when(
        data: (quotes) {
          if (quotes.isEmpty) {
            return const Center(child: Text('Nog geen quotes in deze groep.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: quotes.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final quote = quotes[index];

              // Status bepalen
              final isLiked = userId != null && quote.likedBy.contains(userId);
              final isDisliked =
                  userId != null && quote.dislikedBy.contains(userId);

              final dateStr = DateFormat('dd-MM-yyyy').format(quote.createdAt);

              return Dismissible(
                key: Key(quote.id),
                // Swipe naar RECHTS -> Like (Groen)
                background: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20.0),
                  color: Colors.green.shade100,
                  child: Icon(Icons.favorite, color: Colors.green.shade800),
                ),
                // Swipe naar LINKS -> Dislike (Rood)
                secondaryBackground: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  color: Colors.red.shade100,
                  child: Icon(Icons.thumb_down, color: Colors.red.shade800),
                ),
                // Bevestigingslogica (Actie uitvoeren, maar item NIET verwijderen)
                confirmDismiss: (direction) async {
                  if (userId == null) return false;

                  final repo = ref.read(quotesRepositoryProvider);

                  if (direction == DismissDirection.startToEnd) {
                    // --- ACTIE: SWIPE NAAR RECHTS (LIKE) ---
                    if (!isLiked) {
                      // Als hij disliked was, eerst die weghalen (schoonhouden)
                      if (isDisliked) {
                        await repo.undislikeQuote(quote.id, userId);
                      }
                      await repo.likeQuote(quote.id, userId);
                    }
                  } else {
                    // --- ACTIE: SWIPE NAAR LINKS (DISLIKE) ---
                    if (!isDisliked) {
                      // Als hij geliked was, eerst die weghalen
                      if (isLiked) {
                        await repo.unlikeQuote(quote.id, userId);
                      }
                      await repo.dislikeQuote(quote.id, userId);
                    }
                  }

                  // Return false zodat de rij terugveert en in de lijst blijft staan
                  return false;
                },
                child: ListTile(
                  title: Text(
                    '"${quote.text}"',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text('${quote.saidBy} • $dateStr'),
                  trailing: _buildStatusIcon(isLiked, isDisliked),
                  onTap: () {
                    // Optioneel: Tap om de status te resetten (neutraal maken)
                    if (userId == null) return;
                    final repo = ref.read(quotesRepositoryProvider);

                    if (isLiked) {
                      repo.unlikeQuote(quote.id, userId);
                    } else if (isDisliked) {
                      repo.undislikeQuote(quote.id, userId);
                    }
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Fout: $err')),
      ),
    );
  }

  // Hulp widget voor het icoontje rechts
  Widget _buildStatusIcon(bool isLiked, bool isDisliked) {
    if (isLiked) {
      return const Icon(Icons.favorite, color: Colors.green);
    } else if (isDisliked) {
      return const Icon(Icons.thumb_down, color: Colors.red);
    } else {
      return const Icon(Icons.favorite_border, color: Colors.grey);
    }
  }
}
