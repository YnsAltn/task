import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/features/auth/presentation/models/auth_model.dart';
import 'package:task/features/auth/presentation/services/auth_service.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier(ref.read(authRepositoryProvider));
});

class UserNotifier extends StateNotifier<User?> {
  final AuthRepository _authRepository;
  UserNotifier(this._authRepository) : super(null);

  Future<void> loadUserInfo() async {
    final user = await _authRepository.getUserInfo();
    state = user;
  }

  Future<void> loginUser(String email, String password, bool isChecked) async {
    try {
      final user = await _authRepository.loginUser(email, password, isChecked);
      state = user;
    } catch (e) {
      state = null;
    }
  }
}
