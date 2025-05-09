import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/core/constants/endpoints.dart';
import 'package:task/features/auth/presentations/model/login_model.dart';
import 'package:task/features/auth/presentations/model/login_response_model.dart';

class LoginService {
  Future<LoginResponseModel?> loginUser(
    LoginRequestModel requestModel,
    bool rememberMe,
  ) async {
    final response = await http.post(
      Uri.parse(LOGIN_URL),
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
    } else {
      final responseData = jsonDecode(response.body);
      final errorMessage = responseData['message'] ?? 'Giriş başarısız';
      throw Exception(errorMessage);
    }
  }

  Future<void> _saveUserData(String token, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('user_id', userId);
  }
}
