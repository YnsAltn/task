import 'package:flutter/material.dart';
import 'package:task/colors.dart';

class ForCategory extends StatefulWidget {
  const ForCategory({super.key});

  @override
  State<ForCategory> createState() => _ForCategoryState();
}

class _ForCategoryState extends State<ForCategory> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Icon(Icons.arrow_back_ios, color: appBarTextColor),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.05),
            child: Text(
              "Best Seller",
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
          SingleChildScrollView(scrollDirection: Axis.horizontal),
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
