import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> data = ["All", "Classic", "Horror", "Romance", "Sci-Fi"];
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = data[0];
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          "assets/logo/logo.svg",
          height: 40.h,
          width: 40.w,
          fit: BoxFit.contain,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.05),
            child: Text(
              "Catalog",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: appBarTextColor,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Divider(color: backGrey, thickness: 2),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: data.map((category) => Category(category)).toList(),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: screenWidth * 0.90,
            height: 50,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                filled: true,
                fillColor: backGrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                suffixIcon: Icon(Icons.filter_alt, color: Colors.grey[500]),
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget Category(String category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              selectedCategory == category ? registerButtonTextColor : backGrey,
          foregroundColor:
              selectedCategory == category ? Colors.white : Colors.grey[500],
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: () {
          setState(() {
            selectedCategory = category;
          });
        },
        child: Text(
          category,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
