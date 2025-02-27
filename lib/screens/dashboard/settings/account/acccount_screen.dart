import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/api/api_manager.dart';
import 'package:water_customer_app/screens/signIn/log_in/log_in_screen.dart';
import 'package:water_customer_app/utils/Common.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_button.dart';
import 'package:water_customer_app/utils/globals.dart' as globals;

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration:
                BoxDecoration(gradient: CustomColors.lightBlueGradient()),
            child: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: CustomColors.white, // Set your desired color here
                  size: 20, // Set your desired size here
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                'Account',
                style: whiteTextStyle2,
              ),
              backgroundColor: Colors.transparent,
              // Important to keep AppBar transparent
              elevation: 0, // Optional: Removes shadow
            ),
          ),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                color: CustomColors.datePickerBg,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                    width: 1, color: CustomColors.textBoxBorderColor)),
            width: screenWidth * 0.6,
            height: screenHeight * 0.4,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Username : ',
                      style: grayTextStyle2,
                    ),
                    Text(
                      '${AuthData().username} ',
                      style: grayTextStyle2,
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'UserId : ',
                      style: grayTextStyle2,
                    ),
                    Text(
                      '${AuthData().user_id} ',
                      style: grayTextStyle2,
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'User Type : ',
                      style: grayTextStyle2,
                    ),
                    Text(
                      '${AuthData().user_type} ',
                      style: grayTextStyle2,
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sales Type : ',
                      style: grayTextStyle2,
                    ),
                    Text(
                      '${AuthData().sales_type} ',
                      style: grayTextStyle2,
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * .01,
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                    width: screenWidth * 0.3,
                    child: CustomButton(
                      buttonText: 'Delete Account',
                      tapFunction: () async{
                        bool shouldLogout =
                            await showLogoutConfirmationDialog(context);
                        if (shouldLogout) {
                          AuthData().clearSharedPreferences();
                          Future.delayed(Duration(milliseconds: 200), () {
                            Get.offAll(LogInScreen());
                            print('logout');
                          });
                        }
                      },
                      colorGradient: CustomColors.lightRedGradientNational(),
                      gradiant: true,
                    )),
              ],
            ),
          ),
        )

        // ListView.builder(
        //   itemCount: notifications.length,
        //   itemBuilder: (context, index) {
        //     return NotificationItem(
        //       notifications[index].title,
        //        notifications[index].subtitle,
        //       notifications[index].date,
        //     );
        //   },
        // ),
        );
  }
}
Future<bool> showLogoutConfirmationDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete your account?\n(Our agent will approach you for further procedure)'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              APIManager.postDeleteAccount();
              Navigator.of(context).pop(true);
              },
            child: Text('Delete'),
          ),
        ],
      );
    },
  ) ?? false;
}
