import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/colors.dart';
import 'package:task/view/register_page/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                  "Welcome back!",
                  style: TextStyle(fontSize: 18.sp, color: black),
                ),
                Text(
                  "Login to your account",
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50.h),
                Text(
                  "E-mail",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: inputBoxColor,
                    hintText: "Enter your e-mail",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: black),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: inputBoxColor,
                    hintText: "Enter your password",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
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
                          child: Text("Remember me"),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: Text("Register"),
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: loginButtonColor,
                    fixedSize: Size(360.w, 45.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18.sp, color: white),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
