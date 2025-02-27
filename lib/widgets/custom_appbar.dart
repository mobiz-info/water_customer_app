import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';

import '../screens/notification/notification_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? text;
  final VoidCallback? onBackPressed;  // Nullable back button function

  CustomAppBar(this.text,{  this.onBackPressed});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  final double appBarHeight = kToolbarHeight;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.15,
      decoration: BoxDecoration(
        color: CustomColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                iconSize: appBarHeight * 0.5,
                icon: Icon(Icons.arrow_back, color: CustomColors.text),
                onPressed: () {
                  if (onBackPressed != null) {
                    onBackPressed!(); // Call the provided function if not null
                  } else {
                    Navigator.of(context).pop(); // Default behavior
                  }
                },
              ),
              Center(
                child: Text(
                  text??'',
                  style: grayTextStyle2,
                ),
              ),
              IconButton(
                iconSize: appBarHeight * 0.5,
                icon: Icon(Icons.notifications, color: CustomColors.text),
                onPressed: () {
                  print('Notification button pressed');
                  try {
                    Get.to(NotificationScreen());
                  } catch (e) {
                    print('Error navigating to NotificationScreen: $e');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}