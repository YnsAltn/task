import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task/features/theme/app_theme.dart';
import 'package:task/features/home/presentation/models/product_model.dart';

final favoriteProvider = StateProvider<bool>((ref) => false);

class DetailPage extends ConsumerStatefulWidget {
  final ProductModel product;
  final String imageUrl;

  const DetailPage({super.key, required this.product, required this.imageUrl});

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final isFavorite = ref.watch(favoriteProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.bookDetail,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Divider(color: AppColors.texFormBackground, thickness: 2),
          SizedBox(height: 20.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      widget.imageUrl,
                      width: 150.w,
                      height: 180.h,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return SizedBox(
                          width: 150.w,
                          height: 180.h,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            width: 150.w,
                            height: 180.h,
                            color: AppColors.grey,
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.imageUpload,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.buttonColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0.h,
                  right: 0.w,
                  child: GestureDetector(
                    onTap: () => favorite(ref, isFavorite),
                    child: Image.asset(
                      isFavorite
                          ? "assets/icon/Variant.png"
                          : "assets/icon/Default.png",
                      width: 40.w,
                      height: 40.h,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 15.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.product.name,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  widget.product.author,
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.summary,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  widget.product.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 10,
                  style: TextStyle(fontSize: 15.sp, color: AppColors.black),
                ),
              ],
            ),
          ),

          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${(widget.product.price).toStringAsFixed(2)} ${AppLocalizations.of(context)!.moneyType}",
                  ),
                  Text(AppLocalizations.of(context)!.buyNow),
                ],
              ),
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}

void favorite(WidgetRef ref, bool isFavorite) {
  ref.read(favoriteProvider.notifier).state = !isFavorite;
  if (isFavorite) {
    ScaffoldMessenger.of(ref.context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(ref.context)!.removedFromFavorites),
        duration: Duration(seconds: 1),
      ),
    );
  } else {
    ScaffoldMessenger.of(ref.context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(ref.context)!.addedToFavorites),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
