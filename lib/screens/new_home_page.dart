import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../colors.dart';
import '../components/custom_appbar.dart';
import '../providers/category_provider.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  String? selectedCategory;

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _data = ref.watch(categoryDataProvider);

    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar(
        title: SvgPicture.asset(
          "assets/logo/logo.svg",
          height: 30.h,
          width: 30.w,
          fit: BoxFit.contain,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Text(
              AppLocalizations.of(context)!.catalog,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: _data.when(
        data: (categoryResponse) {
          if (categoryResponse.category.isEmpty) {
            return const Center(child: Text("Kategori bulunamadı"));
          }
          return Column(
            children: [
              Divider(color: backGrey, thickness: 2.h),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        categoryResponse.category
                            .map(
                              (category) => _Category(
                                category.name,
                                selectedCategory: selectedCategory,
                                onCategorySelected: _onCategorySelected,
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                width: 330.w,
                height: 50.h,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.search,
                    filled: true,
                    fillColor: backGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                    suffixIcon: Icon(Icons.filter_alt, color: Colors.grey[500]),
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        error: (err, s) => Center(child: Text("Hata: ${err.toString()}")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _Category extends StatelessWidget {
  final String category;
  final String? selectedCategory;
  final Function(String) onCategorySelected;

  const _Category(
    this.category, {
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              selectedCategory == category ? registerButtonTextColor : backGrey,
          foregroundColor:
              selectedCategory == category ? Colors.white : Colors.grey[500],
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: () => onCategorySelected(category),
        child: Text(
          category,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
