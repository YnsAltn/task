import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Container(
          color: white,
          height: screenHeight,
          width: screenWidth * 0.90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Center(
                child: SvgPicture.asset(
                  "assets/logo/logo.svg",
                  height: 60,
                  width: 60,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 100),
              Text(
                "Welcome back!",
                style: TextStyle(fontSize: 18, color: black),
              ),
              Text(
                "Login to your account",
                style: TextStyle(
                  fontSize: 24,
                  color: black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              Text(
                "E-mail",
                style: TextStyle(
                  fontSize: 18,
                  color: black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 40),
              Text(
                "Password",
                style: TextStyle(
                  fontSize: 18,
                  color: black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
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
                      TextButton(onPressed: () {}, child: Text("Remember me")),
                    ],
                  ),
                  TextButton(onPressed: () {}, child: Text("Register")),
                ],
              ),
              SizedBox(height: 150),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: loginButtonColor,
                  minimumSize: Size(screenWidth * 0.90, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 16, color: white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
