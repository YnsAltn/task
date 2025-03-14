import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import '../models/category_model.dart';

class CategoryService {
  String categoryUrl = "https://assign-api.piton.com.tr/api/rest/categories";

  Future<CategoryResponse> getCategory() async {
    Response response = await get(Uri.parse(categoryUrl));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final result = jsonDecode(response.body);
      return CategoryResponse.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final categoryProvider = Provider<CategoryService>((ref) => CategoryService());
