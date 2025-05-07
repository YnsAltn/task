import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task/features/theme/app_theme.dart';
import 'package:task/features/auth/presentation/components/custom_text_field.dart';
import 'package:task/features/auth/validation.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: AppColors.white,
            height: 690.h,
            width: 330.w,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h),
                  Center(
                    child: SvgPicture.asset(
                      "assets/logo/logo.svg",
                      height: 50.h,
                      width: 50.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 75.h),
                  Text(
                    AppLocalizations.of(context)!.welcome,
                    style: TextStyle(fontSize: 16.sp, color: AppColors.black),
                  ),
                  Text(
                    AppLocalizations.of(context)!.registerMessage,
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Text(
                    AppLocalizations.of(context)!.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    controller: _nameController,
                    hintText: "John Doe",
                    validator: (value) => validateName(context, value),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "E-mail",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    controller: _emailController,
                    hintText: "john@mail.com",
                    validator: (value) => validateEmail(context, value),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    AppLocalizations.of(context)!.password,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: "● ● ● ● ● ● ● ●",
                    validator: (value) => validatePassword(context, value),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          _goLoginPage(context);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  ElevatedButton(
                    child: Text(AppLocalizations.of(context)!.register),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await _registerUser(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(context)!.pleaseFillCorrectly,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _goLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Future<void> _registerUser(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));

    final email = _emailController.text;
    final password = _passwordController.text;
    final name = _nameController.text;

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      throw Exception(AppLocalizations.of(context)!.pleaseFillCorrectly);
    }
  }
}
