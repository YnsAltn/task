class User {
  final String token;
  final String userId;

  User({required this.token, required this.userId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(token: json['token'] ?? '', userId: json['user_id'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'user_id': userId};
  }
}
