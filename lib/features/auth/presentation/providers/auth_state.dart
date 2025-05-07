class AuthState {
  final String? token;
  final String? userId;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.token,
    this.userId,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    String? token,
    String? userId,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      token: token ?? this.token,
      userId: userId ?? this.userId,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
