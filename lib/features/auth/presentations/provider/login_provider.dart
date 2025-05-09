import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/features/auth/presentations/model/login_model.dart';
import 'package:task/features/auth/presentations/service/login_service.dart';
import 'package:task/features/home/presentation/pages/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
part '../states/login_state.dart';

final loginProvider = NotifierProvider<LoginNotifier, LoginState>(
  LoginNotifier.new,
);

class LoginNotifier extends Notifier<LoginState> {
  final LoginService _loginService = LoginService();

  @override
  LoginState build() => const LoginState();

  void setEmail(String email) => state = state.copyWith(email: email);
  void setPassword(String password) =>
      state = state.copyWith(password: password);
  void toggleRememberMe(bool value) =>
      state = state.copyWith(rememberMe: value);
  void reset() => state = const LoginState();

  Future<bool> loginUser(BuildContext context) async {
    if (state.email.isEmpty || state.password.isEmpty) {
      state = state.copyWith(
        errorMessage: AppLocalizations.of(context)!.pleaseFillCorrectly,
      );
      return false;
    }

    state = state.copyWith(isSubmitting: true, errorMessage: null);

    try {
      final model = LoginRequestModel(
        email: state.email,
        password: state.password,
      );
      final response = await _loginService.loginUser(model, state.rememberMe);

      if (response != null && response.token != null) {
        debugPrint("TOKEN: ${response.token}");

        if (state.rememberMe) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", response.token!);
        }

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        }

        return true;
      } else {
        state = state.copyWith(
          errorMessage: AppLocalizations.of(context)!.loginFail,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: "${AppLocalizations.of(context)!.error}: $e",
      );
      return false;
    } finally {
      state = state.copyWith(isSubmitting: false);
    }
  }
}
