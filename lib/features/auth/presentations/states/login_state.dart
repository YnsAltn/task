part of '../provider/login_provider.dart';

class LoginState {
  final String email;
  final String password;
  final bool isSubmitting;
  final String? errorMessage;
  final bool rememberMe;

  const LoginState({
    this.email = '',
    this.password = '',
    this.isSubmitting = false,
    this.errorMessage,
    this.rememberMe = false,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    String? errorMessage,
    bool? rememberMe,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}
