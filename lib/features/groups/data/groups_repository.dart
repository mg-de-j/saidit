import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/group_model.dart';

part 'groups_repository.g.dart';

class GroupsRepository {
  final FirebaseFirestore _firestore;

  GroupsRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _groups =>
      _firestore.collection('groups');

  Future<void> createGroup({
    required String name,
    required String adminId,
  }) async {
    final docRef = _groups.doc();
    final group = Group(
      id: docRef.id,
      name: name,
      adminId: adminId,
      memberIds: [adminId],
      createdAt: DateTime.now(),
    );

    await docRef.set(group.toJson());
  }

  Stream<List<Group>> watchUserGroups(String userId) {
    return _groups
        .where('memberIds', arrayContains: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Group.fromJson(doc.data())).toList(),
        );
  }
}

@riverpod
GroupsRepository groupsRepository(Ref ref) {
  return GroupsRepository(FirebaseFirestore.instance);
}
