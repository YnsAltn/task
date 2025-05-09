import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task/core/theme/app_theme.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _navigateToSearchPage(context);
      },

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.texFormBackground,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 10),
              const Text('Ara...', style: TextStyle(color: Colors.grey)),
              const Spacer(),
              const Icon(Icons.filter_list, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

void _navigateToSearchPage(BuildContext context) {
  context.push('/search');
}
