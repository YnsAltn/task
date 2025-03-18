import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/models/auth_model.dart';

class AuthRepository {
  static const String baseUrl = 'https://assign-api.piton.com.tr/api/rest';

  Future<User?> loginUser(
    String email,
    String password,
    bool rememberMe,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final token = responseData['action_login']['token'];
      final userId = responseData['user_id'] ?? '';

      if (rememberMe) {
        await _saveUserData(token, userId);
      }
      return User(token: token, userId: userId);
    }
    return null;
  }

  Future<void> registerUser(String email, String name, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'name': name, 'password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {}
  }

  Future<User?> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userId = prefs.getString('user_id');
    if (token != null && userId != null) {
      return User(token: token, userId: userId);
    }
    return null;
  }

  Future<void> _saveUserData(String token, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('user_id', userId);
  }
}
