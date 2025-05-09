import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/features/home/presentation/models/product_model.dart';
import 'package:task/features/home/presentation/states/home_state.dart';
import 'package:task/features/home/presentation/services/product_service.dart';
import 'package:task/features/home/presentation/services/category_service.dart';

final homeProvider = AsyncNotifierProvider<HomeNotifier, HomeState>(
  () => HomeNotifier(),
);

class HomeNotifier extends AsyncNotifier<HomeState> {
  final _productService = ProductService();
  final _categoryService = CategoryService();

  @override
  Future<HomeState> build() async {
    final categories = await _categoryService.getCategory();
    final categorizedProducts = <int, List<ProductModel>>{};
    final imageUrls = <int, String>{};

    for (final category in categories) {
      final products = await _productService.getProduct(category.id);
      final productImages = await _fetchImageUrls(products);

      categorizedProducts[category.id] = products;
      imageUrls.addAll(productImages);
    }

    return HomeState(
      categoryModel: categories,
      categorizedProducts: categorizedProducts,
      searchQuery: '',
      imageUrls: imageUrls,
    );
  }

  Future<void> loadCategory(int categoryId) async {
    if (state.value?.categorizedProducts.containsKey(categoryId) == true)
      return;

    final products = await _productService.getProduct(categoryId);
    final productImages = await _fetchImageUrls(products);

    state = AsyncData(
      state.requireValue.copyWith(
        categorizedProducts: {
          ...state.requireValue.categorizedProducts,
          categoryId: products,
        },
        imageUrls: {...state.requireValue.imageUrls, ...productImages},
      ),
    );
  }

  Future<Map<int, String>> _fetchImageUrls(List<ProductModel> products) async {
    final Map<int, String> imageMap = {};
    for (final product in products) {
      try {
        final url = await _productService.getImageUrl(product.cover);
        imageMap[product.id] = url;
      } catch (_) {}
    }
    return imageMap;
  }

  void updateSearchQuery(String query) {
    state = AsyncData(state.requireValue.copyWith(searchQuery: query));
  }

  List<ProductModel> get filteredProducts {
    final allProducts =
        state.requireValue.categorizedProducts.values.expand((e) => e).toList();
    final query = state.requireValue.searchQuery.toLowerCase();

    if (query.isEmpty) return allProducts;

    return allProducts.where((product) {
      return product.name.toLowerCase().contains(query) ||
          product.author.toLowerCase().contains(query);
    }).toList();
  }
}
