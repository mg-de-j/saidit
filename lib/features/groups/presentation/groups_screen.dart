import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/data/auth_repository.dart';
import 'groups_controller.dart';
import 'create_group_sheet.dart';

class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync = ref.watch(userGroupsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SaidIt'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authRepositoryProvider).signOut(),
          ),
        ],
      ),
      body: groupsAsync.when(
        data: (groups) {
          if (groups.isEmpty) {
            return const Center(
              child: Text('Je hebt nog geen groepen.\nMaak er eentje aan!'),
            );
          }
          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return ListTile(
                leading: CircleAvatar(child: Text(group.name[0].toUpperCase())),
                title: Text(group.name),
                subtitle: Text('${group.memberIds.length} leden'),
                onTap: () {
                  context.push('/group/${group.id}');
                },
              );
            },
          );
        },
        error: (err, stack) => Center(child: Text('Fout: $err')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (context) => const CreateGroupSheet(),
        ),
        label: const Text('Nieuwe Groep'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
