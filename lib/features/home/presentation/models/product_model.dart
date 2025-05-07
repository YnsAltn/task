class ProductModel {
  final int id;
  final String name;
  final String author;
  final String cover;
  final String description;
  final double price;

  ProductModel({
    required this.id,
    required this.name,
    required this.author,
    required this.cover,
    required this.description,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
      author: json["author"],
      cover: json["cover"],
      description: json["description"],
      price: (json["price"] as num).toDouble(),
    );
  }
}
