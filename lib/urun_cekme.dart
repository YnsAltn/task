import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/product_model.dart';
import 'services/product_service.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productResponse = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Ürünler")),
      body: FutureBuilder<ProductResponse>(
        future: productResponse.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Hata: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.products.isEmpty) {
            return Center(child: Text("Ürün bulunamadı"));
          }

          final products = snapshot.data!.products;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final fileName = product.cover;

              return FutureBuilder<String>(
                future: ref.watch(productProvider).getImageUrl(fileName),
                builder: (context, imageSnapshot) {
                  if (imageSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return ListTile(
                      title: Text(product.name),
                      subtitle: CircularProgressIndicator(),
                    );
                  }

                  if (imageSnapshot.hasError) {
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text("Resim yüklenemedi"),
                    );
                  }

                  if (imageSnapshot.hasData) {
                    final imageUrl = imageSnapshot.data!;

                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: Image.network(imageUrl),
                        title: Text(product.name),
                        subtitle: Text(product.description),
                      ),
                    );
                  }

                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text("Resim yüklenemedi"),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
