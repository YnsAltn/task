class Product {
  final int id;
  final String name;
  final String author;
  final String cover;
  final DateTime createdAt;
  final String description;
  final double price;
  final int sales;
  final String slug;
  final LikesAggregate? likesAggregate;

  Product({
    required this.id,
    required this.name,
    required this.author,
    required this.cover,
    required this.createdAt,
    required this.description,
    required this.price,
    required this.sales,
    required this.slug,
    this.likesAggregate,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name"],
      author: json["author"],
      cover: json["cover"],
      createdAt: DateTime.parse(json["created_at"]),
      description: json["description"],
      price: (json["price"] as num).toDouble(),
      sales: json["sales"],
      slug: json["slug"],
      likesAggregate:
          json["likes_aggregate"] != null
              ? LikesAggregate.fromJson(json["likes_aggregate"])
              : null,
    );
  }
}

class ProductResponse {
  final List<Product> products;

  ProductResponse({required this.products});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    var list = json['product'] as List;
    List<Product> productList = list.map((i) => Product.fromJson(i)).toList();

    return ProductResponse(products: productList);
  }
}

class LikesAggregate {
  final Aggregate aggregate;

  LikesAggregate({required this.aggregate});

  factory LikesAggregate.fromJson(Map<String, dynamic> json) {
    return LikesAggregate(aggregate: Aggregate.fromJson(json['aggregate']));
  }
}

class Aggregate {
  final int count;

  Aggregate({required this.count});

  factory Aggregate.fromJson(Map<String, dynamic> json) {
    return Aggregate(count: json['count']);
  }
}
