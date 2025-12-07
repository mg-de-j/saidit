import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/quote_model.dart';

part 'quotes_repository.g.dart';

class QuotesRepository {
  final FirebaseFirestore _firestore;

  QuotesRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _quotes =>
      _firestore.collection('quotes');

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
}

@riverpod
QuotesRepository quotesRepository(Ref ref) {
  return QuotesRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<Quote>> groupQuotes(Ref ref, String groupId) {
  return ref.watch(quotesRepositoryProvider).watchGroupQuotes(groupId);
}
