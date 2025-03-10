class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    // null kontrolü ekleyebilirsiniz
    final id = json['id'];
    final name = json['name'];

    if (id == null || name == null) {
      throw Exception('Invalid data: id and name are required');
    }

    return Category(id: id, name: name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
