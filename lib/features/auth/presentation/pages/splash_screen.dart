import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task/features/theme/app_theme.dart';
import 'package:task/features/auth/presentation/pages/login_page.dart';
import 'package:task/features/home/presentation/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false,
        );
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
                  "assets/logo/logo.svg",
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
                    onPressed: () {
                      _loginOnTapped(context);
                    },
                    child: Text(AppLocalizations.of(context)!.login),
                  ),
                  SizedBox(height: 10.h),
                  TextButton(
                    onPressed: () {
                      _skipOnTapped(context);
                    },
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
}

void _loginOnTapped(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
    (route) => false,
  );
}

void _skipOnTapped(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
    (route) => false,
  );
}
