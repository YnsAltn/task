import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
              Text("Welcome", style: TextStyle(fontSize: 18, color: black)),
              Text(
                "Register an account",
                style: TextStyle(
                  fontSize: 24,
                  color: black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              Text(
                "Name",
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
                  hintText: "John Doe",
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [TextButton(onPressed: () {}, child: Text("Login"))],
              ),
              SizedBox(height: 60),
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
