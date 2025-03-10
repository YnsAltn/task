class User {
  final String userId;
  final String email;
  final String name;
  final String password; // Bu alana şifreyi ekledik
  final String token;

  User({
    required this.userId,
    required this.email,
    required this.name,
    required this.password, // Şifreyi burada alıyoruz
    required this.token,
  });

  // JSON'dan User nesnesi oluşturma
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      email: json['email'],
      name: json['name'],
      password: json['password'], // API'den gelen şifre
      token: json['token'],
    );
  }

  // User nesnesini JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'name': name,
      'password': password, // Şifreyi JSON'a ekliyoruz
      'token': token,
    };
  }
}
