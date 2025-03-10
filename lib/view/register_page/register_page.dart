import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/colors.dart';
import 'package:task/view/login_page/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Center(
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
                    width: 50.h,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 75.h),
                Text(
                  "Welcome",
                  style: TextStyle(fontSize: 18.sp, color: black),
                ),
                Text(
                  "Register an account",
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50.h),
                Text(
                  "Name",
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
                    hintText: "John Doe",
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: Text("Login"),
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
                    'Register',
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
