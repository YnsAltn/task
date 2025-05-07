import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/features/auth/presentation/models/register_model.dart';
import 'package:task/features/auth/presentation/models/response_register_model.dart';

class RegisterService {
  static const String baseUrl = 'https://assign-api.piton.com.tr/api/rest';

  Future<RegisterResponseModel?> registerUser(RegisterModel model) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final token = responseData['action_register']['token'];
      final userId = responseData['user_id'] ?? 'default_user_id';

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('user_id', userId);

      return RegisterResponseModel(token: token);
    }

    return null;
  }
}
