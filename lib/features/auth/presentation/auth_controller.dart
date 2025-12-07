import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> login(String email, String password) async {
    final authRepo = ref.read(authRepositoryProvider);

    state = const AsyncLoading();

    try {
      await authRepo.signIn(email, password);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> register(String email, String password) async {
    final authRepo = ref.read(authRepositoryProvider);

    state = const AsyncLoading();

    try {
      await authRepo.register(email, password);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
