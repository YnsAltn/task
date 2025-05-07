import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task/features/auth/presentation/models/auth_model.dart';
import 'package:task/features/auth/presentation/pages/login_page.dart';

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

final TextEditingController emailController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

Future<void> registerUser(BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse('https://assign-api.piton.com.tr/api/rest/register'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'name': nameController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);

      String? token = responseData['action_register']['token'];
      String userId = responseData['user_id'] ?? 'default_user_id';

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.tokenError)),
        );
        return;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('user_id', userId);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${AppLocalizations.of(context)!.registerFail} Status: ${response.statusCode}',
          ),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${AppLocalizations.of(context)!.anErrorOccurred} $e'),
      ),
    );
  }
}
