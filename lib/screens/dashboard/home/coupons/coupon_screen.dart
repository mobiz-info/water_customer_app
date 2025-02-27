import 'package:flutter/material.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/functions.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';
import 'package:water_customer_app/utils/globals.dart' as globals;

class CouponScreen extends StatefulWidget {
  const CouponScreen({super.key});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(''),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.025, vertical: screenHeight * 0.02),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Coupon', style: grayTextStyle3),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  couponTile(
                      'Manual', '${globals.manualCouponNumber}', screenWidth, screenHeight),
                  couponTile(
                      'Digital', '${globals.digitalCouponNumber}', screenWidth, screenHeight),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),

              // Add heading for Manual Coupons section
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Manual Coupons', style: grayTextStyle3),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),

              globals.couponNumberList!.isNotEmpty
                  ? Column(
                children: [
                  Table(
                    border: TableBorder.all(
                      color: CustomColors.containerBorder,
                      width: 1,
                    ),
                    columnWidths: {
                      0: FlexColumnWidth(0.2), // Width for SL column
                      1: FlexColumnWidth(1), // Width for Coupons column
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: CustomColors.datePickerBg,
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'SL',
                              style: grayTextStyle3,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Coupons',
                              style: grayTextStyle3,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: globals.couponNumberList!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Table(
                        border: TableBorder(
                          bottom: BorderSide(
                              color: CustomColors.containerBorder, width: 1),
                          left: BorderSide(
                              color: CustomColors.containerBorder, width: 1),
                          right: BorderSide(
                              color: CustomColors.containerBorder, width: 1),
                          horizontalInside: BorderSide(
                              color: CustomColors.containerBorder, width: 1),
                        ),
                        columnWidths: {
                          0: FlexColumnWidth(0.2),
                          1: FlexColumnWidth(1),
                        },
                        children: [
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  (index + 1).toString(),
                                  style: grayTextStyle2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  globals.couponNumberList![index]
                                      .leafletName ??
                                      '',
                                  style: grayTextStyle2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget couponTile(
      String couponType, String count, double screenWidth, double screenHeight) {
    return Container(
      height: isLandscape(context) ? screenWidth * 0.08 : null,
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.15, vertical: screenHeight * 0.02),
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: CustomColors.containerBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(couponType, style: grayTextStyle2),
          Text(count, style: grayTextStyle2),
        ],
      ),
    );
  }
}
