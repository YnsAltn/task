import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:task/core/constants/endpoints.dart';
import 'package:task/features/home/presentation/components/search_bar_widget.dart';
import 'package:task/features/home/presentation/provider/home_provider.dart';
import 'package:task/core/theme/app_theme.dart';

final selectedCategoryIdProvider = StateProvider<int>((ref) => 0);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SvgPicture.asset(LOGO_PATH, height: 30.h, width: 30.w),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Text(
              AppLocalizations.of(context)!.catalog,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stack) => Center(
              child: Text('${AppLocalizations.of(context)!.error}: $error'),
            ),
        data:
            (data) => SingleChildScrollView(
              child: Column(
                children: [
                  Divider(color: AppColors.texFormBackground, thickness: 2),
                  const SizedBox(height: 16),
                  const _CategoryBar(),
                  const SizedBox(height: 16),
                  const SearchBarWidget(),
                  const SizedBox(height: 16),
                  const _ProductCategoryList(),
                ],
              ),
            ),
      ),
    );
  }
}

class _CategoryBar extends ConsumerWidget {
  const _CategoryBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider).value;
    final selectedCategoryId = ref.watch(selectedCategoryIdProvider);

    if (state == null) {
      return const SizedBox();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategoryButton(
            ref,
            0,
            "${AppLocalizations.of(context)!.all}",
            selectedCategoryId,
          ),
          ...state.categoryModel.map(
            (category) => _buildCategoryButton(
              ref,
              category.id,
              category.name,
              selectedCategoryId,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
    WidgetRef ref,
    int id,
    String label,
    int selectedCategoryId,
  ) {
    final isSelected = selectedCategoryId == id;

    return Padding(
      padding: EdgeInsets.only(left: 15.w),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              isSelected ? AppColors.primaryColor : AppColors.texFormBackground,
          foregroundColor: isSelected ? Colors.white : Colors.grey.shade600,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: () => _onCategorySelected(ref, id),
        child: Text(label, style: TextStyle(fontSize: 14.sp)),
      ),
    );
  }
}

class _ProductCategoryList extends ConsumerWidget {
  const _ProductCategoryList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider).value;
    final selectedCategoryId = ref.watch(selectedCategoryIdProvider);

    if (state == null) {
      return const SizedBox();
    }

    if (selectedCategoryId == 0) {
      return Column(
        children:
            state.categoryModel
                .map(
                  (category) => _ProductCategoryCard(categoryId: category.id),
                )
                .toList(),
      );
    } else {
      return _ProductCategoryCard(categoryId: selectedCategoryId);
    }
  }
}

class _ProductCategoryCard extends ConsumerWidget {
  final int categoryId;

  const _ProductCategoryCard({required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider).value;

    if (state == null) {
      return const SizedBox();
    }

    final category = state.categoryModel.firstWhere(
      (cat) => cat.id == categoryId,
    );
    final categoryProducts = state.categorizedProducts[category.id] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category.name,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => _navigateToCategoryProducts(context, category),
                child: Text(
                  AppLocalizations.of(context)!.viewAll,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.buttonColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 130.h,
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 10.h),
            scrollDirection: Axis.horizontal,
            itemCount: categoryProducts.length,
            itemBuilder: (context, index) {
              final product = categoryProducts[index];
              final imageUrl = state.imageUrls[product.id];

              return GestureDetector(
                onTap: () => _navigateToDetailPage(context, product, imageUrl),
                child: Card(
                  elevation: 0.1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  color: AppColors.texFormBackground,
                  margin: EdgeInsets.only(left: 15.w),
                  child: Container(
                    width: 220.w,
                    padding: EdgeInsets.all(10.w),
                    child: Row(
                      children: [
                        ClipRRect(
                          child:
                              imageUrl != null
                                  ? Image.network(
                                    imageUrl,
                                    width: 80.w,
                                    height: 120.h,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (_, __, ___) => const Icon(Icons.error),
                                  )
                                  : const Icon(Icons.error, size: 80),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h),
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                product.author,
                                style: TextStyle(fontSize: 10.sp),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Text(
                                "${product.price.toStringAsFixed(2)} ${AppLocalizations.of(context)!.moneyType}",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(height: 5.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}

void _onCategorySelected(WidgetRef ref, int id) {
  ref.read(selectedCategoryIdProvider.notifier).state = id;
  final notifier = ref.read(homeProvider.notifier);

  if (id != 0) {
    notifier.loadCategory(id);
  }
}

void _navigateToDetailPage(
  BuildContext context,
  dynamic product,
  String? imageUrl,
) {
  context.push(
    '/details',
    extra: {'product': product, 'imageUrl': imageUrl ?? ''},
  );
}

void _navigateToCategoryProducts(BuildContext context, category) {
  context.push(
    '/category-products',
    extra: {'categoryId': category.id, 'categoryName': category.name},
  );
}
