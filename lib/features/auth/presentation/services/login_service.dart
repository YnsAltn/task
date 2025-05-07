import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/features/auth/presentation/models/login_model.dart';
import 'package:task/features/auth/presentation/models/response_login_model.dart';

class LoginService {
  static const String baseUrl = 'https://assign-api.piton.com.tr/api/rest';

  Future<LoginResponseModel?> loginUser(
    LoginRequestModel requestModel,
    bool rememberMe,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestModel.toJson()),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final token = responseData['action_login']['token'];
      final userId = responseData['user_id'] ?? '';

      if (rememberMe) {
        await _saveUserData(token, userId);
      }

      return LoginResponseModel(token: token);
    }
    return null;
  }

  Future<void> _saveUserData(String token, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('user_id', userId);
  }

  Future<LoginResponseModel?> getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      return LoginResponseModel(token: token);
    }
    return null;
  }
}
