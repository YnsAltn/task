import 'dart:convert';
import 'package:http/http.dart';
import 'package:task/core/constants/endpoints.dart';
import 'package:task/features/home/presentation/models/category_model.dart';

class CategoryService {
  String categoryUrl = CATEGORY_URL;
  Future<List<CategoryModel>> getCategory() async {
    Response response = await get(Uri.parse(categoryUrl));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)["category"];
      return result.map(((e) => CategoryModel.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
