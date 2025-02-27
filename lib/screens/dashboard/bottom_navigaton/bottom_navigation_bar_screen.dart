import 'dart:developer';
import 'dart:io'; // Import this for exit(0)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for SystemNavigator.pop
import 'package:get/get.dart';
import 'package:water_customer_app/screens/dashboard/bottom_navigaton/bottom_navigationbar_controller.dart';
import 'package:water_customer_app/screens/dashboard/cart/cart_screen.dart';
import 'package:water_customer_app/screens/dashboard/home/home_screen.dart';
import 'package:water_customer_app/screens/dashboard/product/product_list_screen.dart';
import 'package:water_customer_app/screens/dashboard/settings/account/acccount_screen.dart';
import 'package:water_customer_app/screens/dashboard/settings/settings_screen.dart';
import 'package:water_customer_app/screens/notification/notification_screen.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';
import 'package:water_customer_app/widgets/custom_navigation_bar.dart';
import 'package:water_customer_app/widgets/drawer.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  final BottomNavigationBarController controller =
      Get.put(BottomNavigationBarController());


  final List<Widget> _screens = [
    HomeScreen(),
    ProductListScreen(),
    CartScreen(),
    SettingsScreen(),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
              color: CustomColors.white,
            ),
            child: _buildAppBar(screenWidth),
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: Obx(() => _screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => CustomBottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.changeTabIndex(index);
          },
        ),
      ),
    );
  }

  Widget _buildAppBar(double screenWidth) {
    if (controller.selectedIndex.value == 0) {
      // Home screen specific AppBar
      return AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Icon(Icons.menu),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.notifications_none_outlined),
              onPressed: () {
                Get.to(() => NotificationScreen());
              },
              color: CustomColors.text,
            ),
            SizedBox(width: 8.0),
            GestureDetector(
              onTap: (){Get.to(AccountScreen());},
              child: CircleAvatar(
                radius: screenWidth * 0.04,
                backgroundImage: AssetImage(
                    'Assets/Images/avatars/avatar-b-1.jpg'), // Avatar image
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      );
    } else {
      // For other tabs, use the custom AppBar
      return CustomAppBar('', onBackPressed: () {
        controller.changeTabIndex(0); // Navigate back to the home tab
      },); // Use a relevant title for each page
    }
  }

}
