import 'package:flutter/material.dart';
import 'package:task/view/detail_page/detail_page.dart';
import 'package:task/view/for_category/for_category.dart';
import 'package:task/view/home_page/home_page.dart';
import 'package:task/view/login_page/login_page.dart';
import 'package:task/view/register_page/register_page.dart';
import 'package:task/view/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: DetailPage());
  }
}
