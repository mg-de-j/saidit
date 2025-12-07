import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/groups/presentation/groups_screen.dart';
import '../../features/quotes/presentation/group_detail_screen.dart';

part 'router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  final authListenable = ValueNotifier<void>(null);

  ref.listen<AsyncValue<User?>>(authStateProvider, (previous, next) {
    authListenable.notifyListeners();
  });

  ref.onDispose(authListenable.dispose);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: authListenable,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);

      final isLoading = authState.isLoading;
      final hasError = authState.hasError;
      final isLoggedIn = authState.value != null;

      final isLoginRoute = state.uri.toString() == '/login';

      if (isLoading || hasError) return null;

      if (!isLoggedIn && !isLoginRoute) {
        return '/login';
      }

      if (isLoggedIn && isLoginRoute) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const GroupsScreen(),
        routes: [
          GoRoute(
            path: 'group/:id',
            builder: (context, state) {
              final groupId = state.pathParameters['id']!;
              return GroupDetailScreen(groupId: groupId);
            },
          ),
        ],
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    ],
  );
}
