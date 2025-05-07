import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/features/auth/presentation/models/login_model.dart';
import 'package:task/features/auth/presentation/providers/auth_state.dart';
import 'package:task/features/auth/presentation/services/auth_service2.dart';

class LoginNotifier extends AsyncNotifier<AuthState> {
  @override
  Future<AuthState> build() async => const AuthState();

  Future<void> login(LoginRequestModel model) async {
    state = const AsyncValue.loading();
    try {
      final response = await ref.read(authServiceProvider).login(model);
      state = AsyncValue.data(
        AuthState(token: response.token, userId: "id_yok", isLoading: false),
      );
    } catch (e) {
      state = AsyncValue.data(AuthState(error: e.toString(), isLoading: false));
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginNotifier, AuthState>(
  () => LoginNotifier(),
);
