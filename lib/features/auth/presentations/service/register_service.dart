import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/core/constants/endpoints.dart';
import '../model/register_model.dart';
import '../model/register_response_model.dart';

class RegisterService {
  Future<RegisterResponseModel?> registerUser(RegisterModel model) async {
    try {
      final response = await http.post(
        Uri.parse(REGISTER_URL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': model.email,
          'name': model.name,
          'password': model.password,
        }),
      );

      print('Register status code: ${response.statusCode}');
      print('Register body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['action_register']['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        return RegisterResponseModel(token: token);
      } else {
        print('Register failed: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Register exception: $e');
      return null;
    }
  }
}
