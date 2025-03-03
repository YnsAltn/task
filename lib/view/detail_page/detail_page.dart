import 'package:flutter/material.dart';
import 'package:task/colors.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
              "Book Details",
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
          Container(width: screenWidth * 0.90),
        ],
      ),
    );
  }
}
