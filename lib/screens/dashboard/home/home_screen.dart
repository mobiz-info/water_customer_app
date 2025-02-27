import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:water_customer_app/screens/dashboard/bottom_navigaton/bottom_navigationbar_controller.dart';
import 'package:water_customer_app/screens/dashboard/cart/cart_screen.dart';
import 'package:water_customer_app/screens/dashboard/home/home_controller.dart';
import 'package:water_customer_app/screens/dashboard/home/order_water/order_water_screen.dart';
import 'package:water_customer_app/screens/dashboard/home/vacation/pause_my_delivery_screen.dart';
import 'package:water_customer_app/utils/Common.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/functions.dart';
import 'package:water_customer_app/utils/styles.dart';

import 'coupons/coupon_screen.dart';
import 'custody_items/custody_item_screen.dart';
import 'my_outstanding/my_outstanding_screen.dart';

import 'purchase_coupon/purchase_coupon_screen.dart';
import 'recharge_for_others/recharge_for_others_screen.dart';
import 'transactions/transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = HomeController();
  final BottomNavigationBarController controller =
      Get.put(BottomNavigationBarController());
  late final List<NavigationItem> navigationItems;
  late final List<NavigationItem> navigationgridIte;

  @override
  void initState() {
    homeController.getNextVisitDate();
    homeController.getCouponBalance();
    homeController.getMyOutStanding();
    homeController.listTheCart();
    navigationgridIte = [
      NavigationItem(
          icon: FaIcon(FontAwesomeIcons.receipt),
          text: 'My Outstanding',
          destination: Obx(
            () => MyOutStandingScreen(
              cash: homeController.outstandingCashBalance.value,
              coupon: homeController.outstandingCouponBalance.value,
              emptyCans: homeController.outstandingCanBalance.value,
            ),
          )),
      NavigationItem(
          icon: FaIcon(FontAwesomeIcons.suitcase),
          text: 'My Custody ',
          destination: const CustodyItemScreen()),
      NavigationItem(
          icon: FaIcon(
            FontAwesomeIcons.suitcase,
          ),
          text: 'Vacation',
          destination: PauseMyDeliveryScreen()),
      NavigationItem(
          icon: FaIcon(FontAwesomeIcons.fileInvoiceDollar),
          text: 'Transactions',
          destination: const TransactionScreen()),
    ];
    navigationItems = [
      NavigationItem(
          icon: FaIcon(FontAwesomeIcons.cartShopping),
          text: 'Order Water',
          destination: const OrderWaterScreen()),
      NavigationItem(
          icon: FaIcon(FontAwesomeIcons.ticket),
          text: 'Buy Coupon',
          destination: const PurchaseCouponScreen()),

      // NavigationItem(
      //     icon: FaIcon(FontAwesomeIcons.personCirclePlus),
      //     text: 'Recharge For Others',
      //     destination: const RechargeForOthersScreen()),
      // NavigationItem(
      //     icon: FaIcon(FontAwesomeIcons.pause),
      //     text: 'Pause/Unpause delivery',
      //     destination: PauseMyDeliveryScreen()),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await _showBackDialog() ?? false;
        if (context.mounted && shouldPop) {
          exit(0);
        }
      },
      child: Scaffold(
        backgroundColor: CustomColors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: [
                profileTile(AuthData().username ?? 'xxx',
                    AuthData().user_id.toString() ?? '12345', screenWidth),
                Obx(() => nextDateStatusTile(
                    homeController.nextVisitDate.value, screenWidth)),
                Obx(() => couponStatusTile(
                    homeController.couponBalance.value,
                    homeController.bottleConceptionCount.value,
                    screenWidth,
                    screenHeight)),
                SizedBox(
                  height: screenHeight * .01,
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: navigationItems.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 15, // Adjust space between items as needed
                  ),
                  itemBuilder: (context, index) => navigationItem(
                    navigationItems[index].icon,
                    navigationItems[index].text,
                    navigationItems[index].destination,
                    screenWidth,
                  ),
                ),
                SizedBox(
                  height: screenHeight * .01,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: navigationgridIte.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10, // Space between columns
                    mainAxisSpacing: 10, // Space between rows
                    childAspectRatio:
                        1.75, // Aspect ratio for the grid items (1 means square)
                  ),
                  itemBuilder: (context, index) => navigationGridItem(
                    index,
                    navigationgridIte[index].icon,
                    navigationgridIte[index].text,
                    navigationgridIte[index].destination,
                    screenWidth,
                  ),
                ),
                SizedBox(
                  height: screenHeight * .02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _showBackDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'Are you sure you want to leave this App?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Nevermind'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Leave'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  Widget profileTile(String name, String customerId, double screenWidth) {
    return Container(
      height: isLandscape(context) ? screenWidth * 0.1 : null,
      margin: EdgeInsets.only(top: screenWidth * .04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, ${name}',
                style: grayTextStyle3,
              ),

              Text(
                'Code : $customerId',
                style: grayTextStyle1,
              ),
              // Text(
              //   'Sales Type : ${AuthData().sales_type}',
              //   style: grayTextStyle1,
              // ),
            ],
          )
        ],
      ),
    );
  }

  Widget nextDateStatusTile(String nextDate, double screenWidth) {
    return Container(
      height: isLandscape(context) ? screenWidth * 0.1 : null,
      margin: EdgeInsets.only(top: screenWidth * .04),
      padding: EdgeInsets.all(
          isLandscape(context) ? screenWidth * 0.01 : screenWidth * .05),
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.containerBorder),
          borderRadius: BorderRadius.circular(8),
          // gradient: CustomColors.lightBlueGradient(),
          color: CustomColors.primaryColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Next delivery',
                style: whiteTextStyle2,
              ),
              Container(
                width: screenWidth * .4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    nextDate,
                    style: whiteTextStyle2,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height:
                isLandscape(context) ? screenWidth * 0.01 : screenWidth * .03,
          ),
        ],
      ),
    );
  }

  Widget couponStatusTile(String couponCount, String bottleConceptionCount,
      double screenWidth, double screenHeight) {
    return Container(
      height: isLandscape(context) ? screenWidth * 0.1 : null,
      margin: EdgeInsets.only(top: screenWidth * .04),
      padding: EdgeInsets.all(
          isLandscape(context) ? screenWidth * 0.01 : screenWidth * .05),
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.containerBorder),
          borderRadius: BorderRadius.circular(8),
          color: CustomColors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
                  mainAxisAlignment: AuthData().sales_type == 'CASH COUPON'?MainAxisAlignment.spaceAround:MainAxisAlignment.center,
                  children: [
                    AuthData().sales_type != 'CASH COUPON'
                        ? SizedBox(): Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Available coupons',
                          style: grayTextStyle1,
                        ),
                        SizedBox(
                          height: screenHeight * .01,
                        ),
                        Center(
                          child: Row(
                            children: [
                              Text(
                                couponCount,
                                style: grayTextStyle2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigate to the desired page when the icon is tapped
                                  Get.to(CouponScreen());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: CustomColors.gridColor,
                                    // Circular container color
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.all(3.0),
                                  // Adjust padding as needed
                                  margin: EdgeInsets.symmetric(
                                      horizontal: screenWidth * .02),
                                  // Adjust padding as needed
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color:
                                        CustomColors.primaryColor, // Icon color
                                    size: 20.0, // Adjust size as needed
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Relationship',
                          style: grayTextStyle1,
                        ),
                        SizedBox(
                          height: screenHeight * .01,
                        ),
                        Center(
                          child: Row(
                            children: [
                              Text(
                                bottleConceptionCount,
                                style: grayTextStyle2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget navigationItem(
      FaIcon icon, String text, Widget destination, double screenWidth) {
    return GestureDetector(
      onTap: () => Get.to(() => destination),
      child: Container(
        height: isLandscape(context) ? screenWidth * 0.08 : null,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: CustomColors.containerBorder),
          color: CustomColors.secondaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.all(10),
                height: screenWidth * .11,
                width: screenWidth * .11,
                decoration: BoxDecoration(
                  color: CustomColors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(child: icon)),
            Spacer(
              flex: 1,
            ),
            Text(text, style: whiteTextStyleBold3),
            Spacer(
              flex: 4,
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: CustomColors.white),
          ],
        ),
      ),
    );
  }

  Widget navigationGridItem(int index, FaIcon icon, String text,
      Widget destination, double screenWidth) {
    return GestureDetector(
      onTapDown: (details) {
        homeController.selectedIndex.value = index;
      },
      onTapUp: (details) {
        homeController.selectedIndex.value = -1;
        Get.to(() => destination); // Navigate to the destination
      },
      child: Obx(
        () => Container(
          height: isLandscape(context) ? screenWidth * 0.08 : null,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: CustomColors.containerBorder),
            color: homeController.selectedIndex.value == index
                ? CustomColors.accentColor
                : CustomColors.gridColor, // Default color
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 10,
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  height: screenWidth * .11,
                  width: screenWidth * .11,
                  child: Center(child: icon)),
              Spacer(
                flex: 1,
              ),
              Text(text,
                  style: homeController.selectedIndex.value == index
                      ? whiteTextStyleBold3
                      : grayTextStyle1),
              Spacer(
                flex: 10,
              ),
              // Spacer(flex: 4,),
              // Icon(Icons.arrow_forward_ios_rounded, color: CustomColors.white),
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider? _getProfileImage(String? name) {
    if (name != null) {
      return AssetImage(name);
    } else {
      return null;
    }
  }

  String _getInitials(String name) {
    List<String> nameParts = name.split(' ');
    if (nameParts.length > 1) {
      print('${nameParts[0][0] + nameParts[nameParts.length - 1][0]}');
      return nameParts[0][0].toUpperCase() +
          nameParts[nameParts.length - 1][0].toLowerCase();
      // return nameParts[0][0];
    } else {
      return nameParts[0][0].toUpperCase();
      // return nameParts[0][0] + nameParts[0][1];
    }
  }

// void navigateToOutstandingItems() {
//   Get.to(() => MyOutStandingScreen(
//     cash: homeController.outstandingCashBalance.value,
//     coupon: homeController.outstandingCouponBalance.value,
//     emptyCans: homeController.outstandingCanBalance.value,
//   ));
// }
}

class NavigationItem {
  final FaIcon icon;
  final String text;
  final Widget destination;

  const NavigationItem(
      {required this.icon, required this.text, required this.destination});
}
