import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/features/home/presentation/models/product_model.dart';
import 'package:task/features/home/presentation/notifier/home_notifier.dart';
import 'package:task/features/home/presentation/pages/detail_page.dart';
import 'package:task/features/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      appBar: _appBar(context),
      body: homeState.when(
        data: (state) {
          final query = state.searchQuery.trim();
          final books = ref.watch(homeProvider.notifier).filteredProducts;

          return Column(
            children: [
              Divider(color: AppColors.texFormBackground, thickness: 2),
              SizedBox(height: 10.h),
              CustomSearchBar(),
              SizedBox(height: 10.h),
              if (query.isNotEmpty)
                Expanded(
                  child:
                      books.isEmpty
                          ? Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: const Text("Ürün Bulunamadı"),
                            ),
                          )
                          : ListView.builder(
                            padding: EdgeInsets.all(16.w),
                            itemCount: books.length,
                            itemBuilder: (context, index) {
                              return buildSearchResultItem(
                                context,
                                ref,
                                books[index],
                              );
                            },
                          ),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Hata: $error')),
      ),
    );
  }

  Widget buildSearchResultItem(
    BuildContext context,
    WidgetRef ref,
    ProductModel book,
  ) {
    final imageUrl = ref.watch(homeProvider).requireValue.imageUrls[book.id];

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: 40.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              image:
                  imageUrl != null
                      ? DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      )
                      : null,
            ),
          ),
          title: Text(
            book.name,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(book.author, style: TextStyle(fontSize: 14.sp)),
          trailing: Text(
            "${book.price.toStringAsFixed(2)} ${AppLocalizations.of(context)!.moneyType}",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          onTap: () {
            if (imageUrl != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          DetailPage(product: book, imageUrl: imageUrl),
                ),
              );
            }
          },
        ),
        Divider(thickness: 1),
      ],
    );
  }
}

class CustomSearchBar extends ConsumerWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .watch(homeProvider)
        .maybeWhen(data: (state) => state.searchQuery, orElse: () => '');

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: TextField(
        onChanged: (value) {
          ref.read(homeProvider.notifier).updateSearchQuery(value);
        },
        cursorColor: Colors.grey.shade600,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.texFormBackground,
          hintText: "Arama Yapın",
          hintStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: const Icon(Icons.filter_list, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.h,
          ),
        ),
      ),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
      onPressed: () => Navigator.pop(context),
    ),
    actions: [
      Padding(
        padding: EdgeInsets.only(right: 15.w),
        child: Text(
          "Arama Sonuçları",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
            color: AppColors.black,
          ),
        ),
      ),
    ],
  );
}
