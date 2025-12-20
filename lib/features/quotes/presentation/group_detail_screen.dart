import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import '../../auth/data/auth_repository.dart';
import '../data/quotes_repository.dart';
import '../domain/quote_model.dart';
import 'add_quote_sheet.dart';

class GroupDetailScreen extends ConsumerStatefulWidget {
  final String groupId;

  const GroupDetailScreen({super.key, required this.groupId});

  @override
  ConsumerState<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends ConsumerState<GroupDetailScreen> {
  final CardSwiperController _controller = CardSwiperController();
  // Geen lokale _undoStack meer nodig!

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSwipe(Quote quote, CardSwiperDirection direction) {
    final userId = ref.read(authRepositoryProvider).currentUser?.uid;
    if (userId == null) return;

    if (direction == CardSwiperDirection.right) {
      ref.read(quotesRepositoryProvider).likeQuote(quote.id, userId);
    } else if (direction == CardSwiperDirection.left) {
      ref.read(quotesRepositoryProvider).dislikeQuote(quote.id, userId);
    }
  }

  Future<void> _handleUndo() async {
    final userId = ref.read(authRepositoryProvider).currentUser?.uid;
    if (userId == null) return;

    // We roepen nu de database aan. De stream update vanzelf de UI.
    await ref.read(quotesRepositoryProvider).undoLastAction(userId);
  }

  @override
  Widget build(BuildContext context) {
    final quotesAsync = ref.watch(groupQuotesProvider(widget.groupId));
    final userId = ref.watch(authRepositoryProvider).currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SaidIt'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            tooltip: 'Bekijk alle quotes',
            onPressed: () => context.go('/group/${widget.groupId}/list'),
          ),
        ],
      ),
      body: quotesAsync.when(
        data: (quotes) {
          if (quotes.isEmpty) {
            return _buildEmptyState(context);
          }

          // Filter quotes die ik al gezien heb
          final playableQuotes = quotes.where((q) {
            final hasLiked = q.likedBy.contains(userId);
            final hasDisliked = q.dislikedBy.contains(userId);
            return !hasLiked && !hasDisliked;
          }).toList();

          final isFinished = playableQuotes.isEmpty;

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: isFinished
                      ? _buildFinishedState(context)
                      : CardSwiper(
                          controller: _controller,
                          cardsCount: playableQuotes.length,
                          numberOfCardsDisplayed: playableQuotes.length < 3
                              ? playableQuotes.length
                              : 3,
                          padding: const EdgeInsets.all(24.0),
                          onSwipe: (previousIndex, currentIndex, direction) {
                            if (previousIndex < playableQuotes.length) {
                              _handleSwipe(
                                playableQuotes[previousIndex],
                                direction,
                              );
                            }
                            return true;
                          },
                          cardBuilder:
                              (
                                context,
                                index,
                                horizontalOffset,
                                verticalOffset,
                              ) {
                                if (index >= playableQuotes.length) {
                                  return const SizedBox.shrink();
                                }
                                return _QuoteCard(quote: playableQuotes[index]);
                              },
                        ),
                ),

                // DE KNOPPEN LOGICA
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 24.0,
                  ),
                  child: isFinished
                      ? Center(
                          // SCENARIO 1: Helemaal klaar? -> ALLEEN Undo knop
                          child: IconButton.filledTonal(
                            onPressed: _handleUndo,
                            icon: const Icon(Icons.rotate_left),
                            tooltip: 'Haal laatste terug',
                            iconSize: 32,
                          ),
                        )
                      : Row(
                          // SCENARIO 2: Nog bezig? -> Undo, Dislike, Like
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Undo
                            IconButton.filledTonal(
                              onPressed: _handleUndo,
                              icon: const Icon(Icons.rotate_left),
                              iconSize: 32,
                            ),

                            // Dislike
                            IconButton.filled(
                              onPressed: () =>
                                  _controller.swipe(CardSwiperDirection.left),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.red.shade100,
                                foregroundColor: Colors.red,
                              ),
                              icon: const Icon(Icons.close),
                              iconSize: 40,
                            ),

                            // Like
                            IconButton.filled(
                              onPressed: () =>
                                  _controller.swipe(CardSwiperDirection.right),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.green.shade100,
                                foregroundColor: Colors.green,
                              ),
                              icon: const Icon(Icons.favorite),
                              iconSize: 40,
                            ),
                          ],
                        ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Fout: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddQuoteModal(context),
        child: const Icon(Icons.add_comment),
      ),
    );
  }

  // Helper widgets voor leesbaarheid
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.format_quote, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'Nog geen quotes in deze groep.',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          const Text('Druk op + om de eerste toe te voegen!'),
        ],
      ),
    );
  }

  Widget _buildFinishedState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
          const SizedBox(height: 16),
          const Text('Helemaal bij!'),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => context.go('/group/${widget.groupId}/list'),
            child: const Text('Bekijk geschiedenis'),
          ),
        ],
      ),
    );
  }

  void _showAddQuoteModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => AddQuoteSheet(groupId: widget.groupId),
    );
  }
}

// _QuoteCard class blijft ongewijzigd... (die was al goed)
class _QuoteCard extends StatelessWidget {
  final Quote quote;

  const _QuoteCard({required this.quote});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      '"${quote.text}"',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                '- ${quote.saidBy}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
