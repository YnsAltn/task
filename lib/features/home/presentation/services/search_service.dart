import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task/core/constants/endpoints.dart';
import 'package:task/features/home/presentation/models/product_model.dart';

class ApiService {
  static Future<List<ProductModel>> fetchAllBooks() async {
    const int totalBooks = 30;
    final futures = List.generate(totalBooks, (i) async {
      final id = i + 1;
      final response = await http.get(Uri.parse('$SEARCH_PRODUCT_URL/$id'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final product = data['product_by_pk'];
        if (product != null) {
          return ProductModel.fromJson(product);
        }
      }
    });

    final results = await Future.wait(futures);
    return results.whereType<ProductModel>().toList();
  }
}
