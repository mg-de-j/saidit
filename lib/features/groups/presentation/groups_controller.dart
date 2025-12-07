import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/data/auth_repository.dart';
import '../data/groups_repository.dart';
import '../domain/group_model.dart';

part 'groups_controller.g.dart';

@riverpod
class GroupsController extends _$GroupsController {
  @override
  FutureOr<void> build() {}

  Future<void> createGroup(String name) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) return;

    final repo = ref.read(groupsRepositoryProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => repo.createGroup(name: name, adminId: currentUser.uid),
    );
  }
}

@riverpod
Stream<List<Group>> userGroups(Ref ref) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) return const Stream.empty();

  return ref.watch(groupsRepositoryProvider).watchUserGroups(user.uid);
}
