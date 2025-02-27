import 'package:flutter/material.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';

class MyOutStandingScreen extends StatelessWidget {
  final String? coupon;
  final String? emptyCans;
  final String? cash;
  const MyOutStandingScreen({this.cash,this.coupon,this.emptyCans,super.key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar('My outstanding'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            outStandingItem("Assets/Images/Home/outstanding/water_can_n.png", "Outstanding bottles",'Qty',emptyCans??"00", screenWidth)
            ,outStandingItem("Assets/Images/Home/outstanding/coupon.png", "Outstanding Coupon", 'Qty',coupon??'00',screenWidth)
           , outStandingItem("Assets/Images/Home/outstanding/cash_image.png", "Outstanding Amount",'AED',cash??'00', screenWidth)
          ],
        ),
      ),
    );
  }

  Widget outStandingItem(String imageUrl, String text,String text2,String count, double screenWidth) {
    return Container(
      margin: EdgeInsets.only(top: screenWidth * 0.04,right: 20,left: 20),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: CustomColors.containerBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CustomColors.transparentColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(imageUrl,height: screenWidth * 0.2,width: screenWidth * 0.2,)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: grayTextStyle2),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:text2,
                      style: grayTextStyle2,
                    ),TextSpan(
                      text: '  ',
                      style: grayHeadStyle1,
                    ),
                    TextSpan(
                      text: count,
                      style: grayHeadStyle1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
