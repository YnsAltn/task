import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../colors.dart';
import '../components/custom_appbar.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar(
        title: Icon(Icons.arrow_back_ios_new),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Text(
              "Book Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Divider(color: backGrey, thickness: 2),
          SizedBox(height: 20),

          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 140.w,
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      spreadRadius: 2,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    "https://img.kitapyurdu.com/v1/getImage/fn:11494736/wh:true/wi:220",
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                top: 0.h,
                right: -80.w,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      isFavorite
                          ? "assets/icon/Variant.png"
                          : "assets/icon/Default.png",
                      width: 25.w,
                      height: 25.h,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 15.h),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text(
                  "Dune",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                ),
              ),
              SizedBox(height: 7.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text(
                  "Frank Herbert",
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
          SizedBox(height: 20.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Summary",
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Bugün stajımın birinci günüydü şirkete gidip bana ayrılan kısıma kuruldum ve daha sonrasında insan kaynakları ekibinden birinin gelip şirketi ve departmanları tanıtması ordakilerle tanıştırması ve bu şekilde oryantasyon eğitiminin tamamlanmasıyla başladı. Oryantasyon bittikten sonra mentörüm biraz geç geleceği için bilgisayara kurulup kendim flutter için state management yöntemlerini araştırmaya başladım. Medium ve flutterın kendi dokümanlarından biraz araştırma yapıp ufak pratikler yapmaya çalıştım. Biraz vakit geçirdikten sonar mentörüm geldi ve onunla da tanıştım bana nasıl başlayacağımı ve neler yapacağımı anlattı. Ilk olarak bazı kurulumlar yapmam gerekti personnellerin iletişim kurduğu platform kurmak mail hesabını açmak gibi. Bunun sonrasında kendimi geliştirmem için bir eğitim projesi verdi projenin detaylarını ve hangi methodları ve paketleri kullanmamız gerektiğininden falan bahsetti. Ama bunun öncesinde git ve githubda kendimi tamamlamam için BTK Akademi platform üzerinden bir eğitim verdi ve ilk olarak bu eğitimi bitirmemi ve giti etkin bir şekilde kullanmamı istedi. Ben de git eğitimine başladım temel komutları ve işlevleri Pratik yaparak öğrenmeye çalıştım bugün git ve github eğitimin bir kısmını bitirdim ve günüm bu şekilde geçti.",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 10,
                  style: TextStyle(fontSize: 16.sp, color: black),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: loginButtonColor,
                fixedSize: Size(360.w, 45.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '99.99 TL',
                    style: TextStyle(fontSize: 18.sp, color: white),
                  ),
                  Text(
                    "Buy Now",
                    style: TextStyle(fontSize: 18.sp, color: white),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
