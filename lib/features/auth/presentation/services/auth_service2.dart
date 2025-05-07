import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task/features/auth/presentation/models/login_model.dart';
import 'package:task/features/auth/presentation/models/response_login_model.dart';
import 'package:task/features/auth/presentation/models/response_register_model.dart';
import '../models/register_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthService {
  static const String baseUrl = 'https://assign-api.piton.com.tr/api/rest';

  Future<LoginResponseModel> login(LoginRequestModel model) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return LoginResponseModel.fromJson(json['action_login']);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<RegisterResponseModel> register(RegisterModel model) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return RegisterResponseModel.fromJson(json['action_register']);
    } else {
      throw Exception('Register failed: ${response.body}');
    }
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
