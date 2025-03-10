import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductModel {
  List<Product>? product;

  ProductModel({this.product});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? author;
  String? cover;
  String? createdAt;
  String? description;
  int? id;
  String? name;
  double? price;
  int? sales;
  String? slug;
  LikesAggregate? likesAggregate;
  String? fileName;
  String? coverUrl;

  Product({
    this.author,
    this.cover,
    this.createdAt,
    this.description,
    this.id,
    this.name,
    this.price,
    this.sales,
    this.slug,
    this.likesAggregate,
    this.fileName,
    this.coverUrl,
  });

  Product.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    cover = json['cover'];
    createdAt = json['created_at'];
    description = json['description'];
    id = json['id'];
    name = json['name'];
    price =
        json['price'] != null
            ? double.tryParse(json['price'].toString())
            : null;
    sales = json['sales'];
    slug = json['slug'];
    likesAggregate =
        json['likes_aggregate'] != null
            ? LikesAggregate.fromJson(json['likes_aggregate'])
            : null;
    fileName = json['action_product_image']?['url'];
    coverUrl = fileName ?? ''; // İlk başta fileName ile dolduruluyor
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['author'] = author;
    data['cover'] = cover;
    data['created_at'] = createdAt;
    data['description'] = description;
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['sales'] = sales;
    data['slug'] = slug;
    if (likesAggregate != null) {
      data['likes_aggregate'] = likesAggregate!.toJson();
    }
    if (fileName != null) {
      data['action_product_image'] = {'url': fileName};
    }
    return data;
  }

  Future<String> getCoverUrl() async {
    if (fileName != null) {
      return fileName!; // Eğer fileName varsa, onu döndürüyoruz
    }
    if (cover != null) {
      final response = await http.get(
        Uri.parse(
          'https://assign-api.piton.com.tr/api/rest/cover_image?cover=$cover',
        ),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final String coverFileName = jsonData['fileName'];
        return "https://s3.piton.com.tr/assignment/$coverFileName";
      } else {
        throw Exception('Failed to load cover image');
      }
    }
    throw Exception('No cover available');
  }
}

class LikesAggregate {
  Aggregate? aggregate;

  LikesAggregate({this.aggregate});

  LikesAggregate.fromJson(Map<String, dynamic> json) {
    aggregate =
        json['aggregate'] != null
            ? Aggregate.fromJson(json['aggregate'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    return data;
  }
}

class Aggregate {
  int? count;

  Aggregate({this.count});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['count'] = this.count;
    return data;
  }
}
