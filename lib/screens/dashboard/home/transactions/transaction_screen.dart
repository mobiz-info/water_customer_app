import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/screens/dashboard/cart/cart_screen.dart';
import 'package:water_customer_app/screens/dashboard/home/home_screen.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';

import 'purchase/purchase_screen.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late final List<NavigationItem> transactionItems;

  @override
  void initState() {
    transactionItems = [
      NavigationItem(
          icon: FaIcon(FontAwesomeIcons.tags),
          text: 'Coupon Purchases',
          destination: const PurchaseScreen(
            appTittle: 'Coupon Purchases',
          )),
      NavigationItem(
          icon: FaIcon(FontAwesomeIcons.bottleWater),
          text: 'Water Bottle Purchase',
          destination:const PurchaseScreen(
            appTittle: 'Water Bottle Purchase',
          )),
      NavigationItem(
          icon: FaIcon(FontAwesomeIcons.deviantart),
          text: 'Dispenser & Cooler Purchase',
          destination: const PurchaseScreen(
            appTittle: 'Dispenser & Cooler Purchase',
          )),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar('My transactions'),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: ListView.separated(
          itemCount: transactionItems.length,
          separatorBuilder: (context, index) => SizedBox(
            height: 10, // Adjust space between items as needed
          ),
          itemBuilder: (context, index) => navigationItem(
            transactionItems[index].icon,
            transactionItems[index].text,
            transactionItems[index].destination,
            screenWidth,
          ),
        ),
      ),
    );
  }

  Widget navigationItem(
      FaIcon icon, String text, Widget destination, double screenWidth) {
    return GestureDetector(
      onTap: () {
        Get.to( destination);
        print(text);
      },
      child: Container(
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
                height: screenWidth * .11,
                width: screenWidth * .11,
                decoration: BoxDecoration(
                  color: CustomColors.homeListIconBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: icon)),
            Spacer(
              flex: 1,
            ),
            Text(text, style: grayTextStyle1),
            Spacer(
              flex: 4,
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: CustomColors.text),
          ],
        ),
      ),
    );
  }
}
