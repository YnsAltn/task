import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/models/category_model.dart';
import 'models/product_model.dart';
import 'services/product_service.dart';
import 'providers/category_provider.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productResponse = ref.watch(productProvider);
    final categoryResponse = ref.watch(categoryDataProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Ürünler")),
      body: categoryResponse.when(
        data: (categoryData) {
          if (categoryData.category.isEmpty) {
            return const Center(child: Text("Kategori bulunamadı"));
          }

          return FutureBuilder<ProductResponse>(
            future: productResponse.getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.products.isEmpty) {
                return const Center(child: Text("Ürün bulunamadı"));
              }

              final products = snapshot.data!.products;

              // 📌 İlk ürünün kategorisini al
              final firstCategory = categoryData.category.firstWhere(
                (c) => c.id == products.first.id,
                orElse:
                    () => CategoryList(
                      id: 0,
                      name: "Bilinmeyen Kategori",
                      createdAt: DateTime.now(),
                    ),
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 📌 Kategori Adını Sadece Bir Kere Üstte Göster
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    color: Colors.blueAccent.withOpacity(0.2),
                    child: Text(
                      firstCategory.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // 📌 Ürünleri Listele
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            products.map((product) {
                              final fileName = product.cover;

                              return FutureBuilder<String>(
                                future: ref
                                    .watch(productProvider)
                                    .getImageUrl(fileName),
                                builder: (context, imageSnapshot) {
                                  if (imageSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return SizedBox(
                                      width: 200,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  if (imageSnapshot.hasError) {
                                    return SizedBox(
                                      width: 200,
                                      child: Center(
                                        child: Text("Resim yüklenemedi"),
                                      ),
                                    );
                                  }

                                  if (imageSnapshot.hasData) {
                                    final imageUrl = imageSnapshot.data!;

                                    return Card(
                                      margin: const EdgeInsets.all(8),
                                      child: SizedBox(
                                        height: 140,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Image.network(
                                                imageUrl,
                                                width: 80,
                                                height: 130,
                                                fit: BoxFit.cover,
                                              ),
                                              const SizedBox(width: 10),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                      10,
                                                      10,
                                                      20,
                                                      10,
                                                    ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      product.name,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      product.author,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      "${product.price} ₺",
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  return SizedBox();
                                },
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        error: (err, s) => Center(child: Text("Hata: ${err.toString()}")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
