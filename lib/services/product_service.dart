import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductService {
  var productUrl = Uri.parse(
    "https://assign-api.piton.com.tr/api/rest/products/1",
  );

  var imageUrl = Uri.parse(
    "https://assign-api.piton.com.tr/api/rest/cover_image",
  );

  Future<ProductResponse> getProducts() async {
    http.Response response = await http.get(
      productUrl,
      headers: {'x-hasura-user-id': '422'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final result = jsonDecode(response.body);
      return ProductResponse.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<String> getImageUrl(String fileName) async {
    final response = await http.post(
      imageUrl,
      headers: {'x-hasura-user-id': '422'},
      body: jsonEncode({'fileName': fileName}),
    );

    print("Resim isteği sonucu: ${response.body}");

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
