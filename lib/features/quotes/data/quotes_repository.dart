import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/quote_model.dart';

part 'quotes_repository.g.dart';

class QuotesRepository {
  final FirebaseFirestore _firestore;

  QuotesRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _quotes =>
      _firestore.collection('quotes');

  // Collectie voor geschiedenis logs
  CollectionReference<Map<String, dynamic>> get _actions =>
      _firestore.collection('quote_actions');

  Future<void> addQuote({
    required String text,
    required String saidBy,
    required String groupId,
    required String userId,
  }) async {
    final docRef = _quotes.doc();
    final quote = Quote(
      id: docRef.id,
      text: text,
      saidBy: saidBy,
      addedByUserId: userId,
      groupId: groupId,
      createdAt: DateTime.now(),
    );

    await docRef.set(quote.toJson());
  }

  Stream<List<Quote>> watchGroupQuotes(String groupId) {
    return _quotes
        .where('groupId', isEqualTo: groupId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Quote.fromJson(doc.data())).toList(),
        );
  }

  // --- SWIPE LOGICA (Batch + Timestamp) ---

  Future<void> likeQuote(String quoteId, String userId) async {
    final batch = _firestore.batch();

    // 1. Update de Quote
    batch.update(_quotes.doc(quoteId), {
      'likes': FieldValue.increment(1),
      'likedBy': FieldValue.arrayUnion([userId]),
    });

    // 2. Log de actie
    final actionRef = _actions.doc();
    batch.set(actionRef, {
      'userId': userId,
      'quoteId': quoteId,
      'action': 'like',
      'timestamp': FieldValue.serverTimestamp(),
    });

    await batch.commit();
  }

  Future<void> dislikeQuote(String quoteId, String userId) async {
    final batch = _firestore.batch();

    batch.update(_quotes.doc(quoteId), {
      'dislikedBy': FieldValue.arrayUnion([userId]),
    });

    final actionRef = _actions.doc();
    batch.set(actionRef, {
      'userId': userId,
      'quoteId': quoteId,
      'action': 'dislike',
      'timestamp': FieldValue.serverTimestamp(),
    });

    await batch.commit();
  }

  // --- UNDO / REMOVE LOGICA (Handmatig of via Undo knop) ---

  Future<void> unlikeQuote(String quoteId, String userId) async {
    final batch = _firestore.batch();

    // 1. Update de Quote (Like weghalen)
    batch.update(_quotes.doc(quoteId), {
      'likes': FieldValue.increment(-1),
      'likedBy': FieldValue.arrayRemove([userId]),
    });

    // 2. Schoon ook de history op (zodat de undo stack klopt)
    // We zoeken de log entries voor deze like
    final snapshot = await _actions
        .where('userId', isEqualTo: userId)
        .where('quoteId', isEqualTo: quoteId)
        .where('action', isEqualTo: 'like')
        .get();

    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  Future<void> undislikeQuote(String quoteId, String userId) async {
    final batch = _firestore.batch();

    // 1. Update de Quote (Dislike weghalen)
    batch.update(_quotes.doc(quoteId), {
      'dislikedBy': FieldValue.arrayRemove([userId]),
    });

    // 2. Schoon history op
    final snapshot = await _actions
        .where('userId', isEqualTo: userId)
        .where('quoteId', isEqualTo: quoteId)
        .where('action', isEqualTo: 'dislike')
        .get();

    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  // --- GLOBAL UNDO (Voor de knop onder de stapel) ---

  Future<void> undoLastAction(String userId) async {
    // Haal de allerlaatste actie van deze user op
    final snapshot = await _actions
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return;

    final actionDoc = snapshot.docs.first;
    final data = actionDoc.data();
    final String quoteId = data['quoteId'];
    final String actionType = data['action'];

    final batch = _firestore.batch();

    if (actionType == 'like') {
      batch.update(_quotes.doc(quoteId), {
        'likes': FieldValue.increment(-1),
        'likedBy': FieldValue.arrayRemove([userId]),
      });
    } else if (actionType == 'dislike') {
      batch.update(_quotes.doc(quoteId), {
        'dislikedBy': FieldValue.arrayRemove([userId]),
      });
    }

    // Verwijder de log entry
    batch.delete(actionDoc.reference);

    await batch.commit();
  }
}

@riverpod
QuotesRepository quotesRepository(Ref ref) {
  return QuotesRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<Quote>> groupQuotes(Ref ref, String groupId) {
  return ref.watch(quotesRepositoryProvider).watchGroupQuotes(groupId);
}
