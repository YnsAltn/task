import 'package:task/features/home/presentation/models/category_model.dart';
import 'package:task/features/home/presentation/models/product_model.dart';

class HomeState {
  final Map<int, List<ProductModel>> categorizedProducts;
  final List<CategoryModel> categoryModel;
  final String searchQuery;
  final Map<int, String> imageUrls;

  const HomeState({
    required this.categorizedProducts,
    required this.categoryModel,
    required this.searchQuery,
    required this.imageUrls,
  });

  HomeState copyWith({
    Map<int, List<ProductModel>>? categorizedProducts,
    List<CategoryModel>? categoryModel,
    String? searchQuery,
    Map<int, String>? imageUrls,
  }) {
    return HomeState(
      categorizedProducts: categorizedProducts ?? this.categorizedProducts,
      categoryModel: categoryModel ?? this.categoryModel,
      searchQuery: searchQuery ?? this.searchQuery,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }
}
