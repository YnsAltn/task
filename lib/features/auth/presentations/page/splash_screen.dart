import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:task/core/constants/endpoints.dart';
import 'package:task/core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _navigateToHome(context);
      }
    });
    return Scaffold(
      body: Stack(
        children: [
          Container(color: AppColors.splashBackgroundColor),
          Positioned(
            left: 0,
            right: 0,
            top: 150.h,
            child: Column(
              children: [
                SvgPicture.asset(
                  LOGO_PATH,
                  height: 170.h,
                  width: 170.w,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () => _navigateToLogin(context),
                    child: Text(AppLocalizations.of(context)!.login),
                  ),
                  SizedBox(height: 10.h),
                  TextButton(
                    onPressed: () => _navigateToHome(context),
                    child: Text(
                      AppLocalizations.of(context)!.skip,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToLogin(BuildContext context) {
    context.go('/login');
  }

  void _navigateToHome(BuildContext context) {
    context.go('/');
  }
}
