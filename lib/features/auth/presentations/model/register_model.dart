class RegisterModel {
  final String email;
  final String name;
  final String password;

  RegisterModel({
    required this.email,
    required this.name,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'password': password,
  };
}
