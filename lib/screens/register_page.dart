import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../colors.dart';
import '../components/custom_button.dart';
import '../validation.dart';
import 'login_page.dart';

final _formKey = GlobalKey<FormState>();

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Center(
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
                      width: 50.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 75.h),
                  Text(
                    AppLocalizations.of(context)!.welcome,
                    style: TextStyle(fontSize: 16.sp, color: black),
                  ),
                  Text(
                    AppLocalizations.of(context)!.registerMessage,
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Text(
                    AppLocalizations.of(context)!.name,
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
                      hintText: "John Doe",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: validateName,
                    style: TextStyle(color: black),
                  ),
                  SizedBox(height: 20.h),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(AppLocalizations.of(context)!.login),
                      ),
                    ],
                  ),
                  Spacer(),
                  CustomButton(
                    text: AppLocalizations.of(context)!.register,
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
