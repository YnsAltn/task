import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:task/core/constants/endpoints.dart';
import 'package:task/features/home/presentation/models/product_model.dart';

class ProductService {
  Future<List<ProductModel>> getProduct(int categoryId) async {
    final String url = '$PRODUCT_URL/$categoryId';

    final response = await http.get(
      Uri.parse(url),
      headers: {'x-hasura-user-id': '422'},
    );

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)["product"];
      return result.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<String> getImageUrl(String fileName) async {
    final response = await http.post(
      Uri.parse(PRODUCT_IMAGE_URL),
      headers: {'x-hasura-user-id': '422'},
      body: jsonEncode({'fileName': fileName}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        final result = jsonDecode(response.body);
        return result['action_product_image']['url'];
      } catch (e) {
        throw Exception("Resim URL'si çıkarılamadı: ${e.toString()}");
      }
    } else {
      throw Exception("Resim yüklenemedi: ${response.reasonPhrase}");
    }
  }
}

final productProvider = Provider<ProductService>((ref) => ProductService());
