class CategoryList {
  final int id;
  final String name;
  final DateTime createdAt;

  CategoryList({required this.id, required this.name, required this.createdAt});

  factory CategoryList.fromJson(Map<String, dynamic> json) {
    return CategoryList(
      id: json["id"],
      name: json["name"],
      createdAt: DateTime.parse(json["created_at"]),
    );
  }
}

class CategoryResponse {
  final List<CategoryList> category;

  CategoryResponse({required this.category});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    var list = json['category'] as List;
    List<CategoryList> categoryList =
        list.map((i) => CategoryList.fromJson(i)).toList();

    return CategoryResponse(category: categoryList);
  }
}
