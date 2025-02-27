import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/screens/dashboard/bottom_navigaton/bottom_navigationbar_controller.dart';
import 'package:water_customer_app/screens/dashboard/bottom_navigaton/drawer/privacy_policy/privacy_policy_screen.dart';
import 'package:water_customer_app/screens/dashboard/settings/account/acccount_screen.dart';
import 'package:water_customer_app/screens/dashboard/settings/help/help_screen.dart';
import 'package:water_customer_app/screens/dashboard/settings/settings_controller.dart';
import 'package:water_customer_app/screens/notification/notification_screen.dart';
import 'package:water_customer_app/utils/colors.dart';

import 'about/about_screen.dart';



class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsController settingsController=SettingsController();
  // bool isNotificationsEnabled = true;
  final BottomNavigationBarController controller =
  Get.put(BottomNavigationBarController());
@override
  void initState() {
     settingsController.themeStatus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {

          controller.changeTabIndex(0);

          //exit(0);
        }
      },
      child: Scaffold(
        backgroundColor: CustomColors.white,
        body: ListView(
          children: [
            // Obx(() =>

                _buildListTile(
                title: 'Notifications',
                subtitle: 'Manage notifications settings',
                leadingIcon: Icons.notifications,
                // trailingWidget: Switch(
                //   value: settingsController.isNotificationEnabled.value,
                //   onChanged: (bool value) {
                //
                //     settingsController.notificationStatusToggle();
                //   },
                // ),
                onTap: () {
                  Get.to(NotificationScreen());
                },
              ),
            // ),
            // Divider(),
            // _buildListTile(
            //   title: 'Account',
            //   subtitle: 'Manage your account settings',
            //   leadingIcon: Icons.account_circle,
            //   onTap: () {
            //     print('Account tapped');
            //     // Navigate to account settings screen
            //   },
            // ),
            Divider(),
            _buildListTile(
              title: 'Privacy',
              subtitle: 'Update your privacy settings',
              leadingIcon: Icons.lock,
              onTap: () {
                Get.to(PrivacyPolicyScreen());
              },
            ),
            // Divider(),
            // Obx(() =>_buildListTile(
            //     title: 'Dark Mode',
            //     subtitle: 'Toggle dark mode',
            //     leadingIcon: Icons.brightness_6,
            //     trailingWidget: Switch(
            //       value: settingsController.isDarkModeEnabled.value,
            //       onChanged: (bool value) {
            //         settingsController.toggleTheme();
            //       },
            //     ),
            //     onTap: () {
            //       print('Dark Mode tapped');
            //     },
            //   ),
            // ),
            // Divider(),
            // _buildListTile(
            //   title: 'Language',
            //   subtitle: 'Change app language',
            //   leadingIcon: Icons.language,
            //   onTap: () {
            //     print('Language tapped');
            //     // Navigate to language settings screen
            //   },
            // ),
            Divider(),
            _buildListTile(
              title: 'Help',
              subtitle: 'Get help and support',
              leadingIcon: Icons.help,
              onTap: () {
                print('Help tapped');
                Get.to(()=>HelpScreen());

                // Navigate to help screen
              },
            ),
            Divider(),
            _buildListTile(
              title: 'About',
              subtitle: 'Learn more about the app',
              leadingIcon: Icons.info,
              onTap: () {
                print('About tapped');
                Get.to(()=>AboutScreen());
                // Navigate to about screen
              },
            ),
            Divider(),
            _buildListTile(
              title: 'Account',
              subtitle: 'Manage Account',
              leadingIcon: Icons.person,
              onTap: () {
                Get.to(AccountScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile({
    required String title,
    required String subtitle,
    required IconData leadingIcon,
    Widget? trailingWidget,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailingWidget,
      onTap: onTap,
    );
  }
}
