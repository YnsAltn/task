import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../colors.dart';
import '../components/custom_button.dart';
import '../validation.dart';
import 'register_page.dart';

final _formKey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: white,
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
                      width: 50.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 75.h),
                  Text(
                    AppLocalizations.of(context)!.welcomeBack,
                    style: TextStyle(fontSize: 16.sp, color: black),
                  ),
                  Text(
                    AppLocalizations.of(context)!.loginMessage,
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Text(
                    "E-mail",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: inputBoxColor,
                      hintText: "john@mail.com",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: validateEmail,
                    style: TextStyle(color: black),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    AppLocalizations.of(context)!.password,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: inputBoxColor,
                      hintText: "● ● ● ● ● ● ● ●",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: validatePassword,
                    style: TextStyle(color: black),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox.adaptive(
                            value: false,
                            onChanged: (bool? value) {},
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              AppLocalizations.of(context)!.rememberMe,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                        child: Text(AppLocalizations.of(context)!.register),
                      ),
                    ],
                  ),
                  Spacer(),
                  CustomButton(
                    text: AppLocalizations.of(context)!.login,
                    onPressed: () {
                      _formKey.currentState!.validate();
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
}
