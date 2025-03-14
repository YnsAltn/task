import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';

final productDataProvider = FutureProvider<ProductResponse>((ref) async {
  return ref.watch(productProvider).getProducts();
});
