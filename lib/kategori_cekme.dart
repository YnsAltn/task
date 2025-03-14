import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/category_provider.dart';

class MyHomePage2 extends ConsumerWidget {
  const MyHomePage2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(categoryDataProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Deneme")),
      body: _data.when(
        data: (categoryResponse) {
          if (categoryResponse.category.isEmpty) {
            return const Center(child: Text("Kategori bulunamadı"));
          }

          return ListView.builder(
            itemCount: categoryResponse.category.length,
            itemBuilder: (_, index) {
              final category = categoryResponse.category[index];

              return Card(
                color: const Color.fromARGB(99, 99, 99, 99),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  title: Text(category.id.toString()),
                  subtitle: Text(category.name),
                ),
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
