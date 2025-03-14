import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../colors.dart';
import '../components/custom_appbar.dart';

class ForCategory extends StatefulWidget {
  const ForCategory({super.key});

  @override
  State<ForCategory> createState() => _ForCategoryState();
}

class _ForCategoryState extends State<ForCategory> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar(
        title: Icon(Icons.arrow_back_ios_new),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Text(
              "Best Seller",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Divider(color: backGrey, thickness: 2),
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
