import 'package:flutter/material.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/functions.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double navBarHeight = screenHeight * 0.1;
    double iconSize = screenWidth * 0.07; // Adjust the size based on screen width
    double padding = screenWidth * 0.02; // Adjust padding based on screen width

    return Container(
      height: !isLandscape(context) ?navBarHeight:screenHeight * 0.18,
      decoration: BoxDecoration(
        color: CustomColors.white, // Set your background color here

        boxShadow: [
          BoxShadow(
            color: CustomColors.text.withOpacity(0.2),
            blurRadius: 2,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', 0, iconSize, padding),
          _buildNavItem(Icons.pending_actions_rounded, 'Products', 1, iconSize, padding),
          _buildNavItem(Icons.shopping_cart_outlined, 'Cart', 2, iconSize, padding),
          // Uncomment if you want to include a 'Cart' item
          // _buildNavItem(Icons.shopping_cart, 'Cart', 2, iconSize, padding),
          _buildNavItem(Icons.settings, 'Settings', 3, iconSize, padding),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, double iconSize, double padding) {
    return InkWell(
      onTap: () => onTap(index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentIndex == index
              ? CustomColors.accentColor
              : CustomColors.transparentColor,
        ),
        padding: EdgeInsets.all(currentIndex == index ? padding : 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: currentIndex == index ? CustomColors.white : CustomColors.text,
            ),
            SizedBox(height: 4),
            currentIndex == index ?SizedBox():
            Text(
              label,
              style: TextStyle(
                fontSize: currentIndex == index ? 0 : 12, // Dynamic font size
                color: currentIndex == index ? CustomColors.white : CustomColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
