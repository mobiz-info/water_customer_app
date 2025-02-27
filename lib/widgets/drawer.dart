

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/screens/dashboard/bottom_navigaton/drawer/deals/deals_screen.dart';
import 'package:water_customer_app/screens/dashboard/bottom_navigaton/drawer/feedback/feedback_screen.dart';
import 'package:water_customer_app/screens/dashboard/bottom_navigaton/drawer/privacy_policy/privacy_policy_screen.dart';
import 'package:water_customer_app/screens/dashboard/bottom_navigaton/drawer/profile/my_profile_screen.dart';
import 'package:water_customer_app/screens/dashboard/bottom_navigaton/drawer/rate_this_app/rate_this_app_screen.dart';
import 'package:water_customer_app/screens/dashboard/bottom_navigaton/drawer/terms_and_conditions/term_and_conditions_screen.dart';
import 'package:water_customer_app/screens/new_request/new_complaint_screen.dart';
import 'package:water_customer_app/screens/signIn/log_in/log_in_screen.dart';
import 'package:water_customer_app/utils/Common.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(

        decoration: BoxDecoration(
          gradient: CustomColors.lightGrayGradient(),
        ),
        child: ListView.separated(
            itemCount: 8,
            separatorBuilder: (context, index) => Divider(
              thickness: 0.2, // Adjust divider thickness as needed
              color: CustomColors
                  .containerBorder, // Customize divider color (optional)
            ),
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: CustomColors.containerBorder)
                    ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'Assets/Images/drawerImage.png',
                            height: MediaQuery.of(context).size.height * .08,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AuthData().username ?? '',
                                style: grayTextStyle2,
                              ),
                              GestureDetector(
                                onTap: (){
                                  // Get.to(MyProfileScreen());
                                },
                                child: Text(
                                  "View my profile",
                                  style: grayTextStyle1,
                                ),
                              ),
                              Text("version: ${versionNo}",style:TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: Colors.grey,
                              ) ,),
                            ],
                          )
                        ],
                      ));
                // case 1:
                //   return myDrawerTile(
                //     icon: FaIcon(FontAwesomeIcons.certificate),
                //     title: "Deals",//remove
                //     onTap: () {
                //       print('test');
                //        Get.to(DealsScreen());
                //     },
                //   );
                case 1:
                  return myDrawerTile(
                    icon:FaIcon(FontAwesomeIcons.solidCommentDots),
                    title: "Feedback",
                    onTap: () {
                      Get.to(FeedbackScreen());
                    },
                  );
                // case 2:
                //   return myDrawerTile(
                //     icon: FaIcon(FontAwesomeIcons.gift),
                //     title: "Refer & earn",
                //     onTap: () {
                //       // Handle navigation or other logic
                //     },
                //   );

                case 2:
                  return myDrawerTile(
                    icon: FaIcon(FontAwesomeIcons.list),
                    title: "Terms & conditions",
                    onTap: () {
                      Get.to(TermsAndConditionsScreen());
                    },
                  );
                case 3:
                  return myDrawerTile(
                    icon:FaIcon(FontAwesomeIcons.solidSquare),
                    title: "Privacy policy",
                    onTap: () {
                      Get.to(PrivacyPolicyScreen());
                    },
                  );
                // case 7:
                //   return myDrawerTile(
                //     icon: FaIcon(FontAwesomeIcons.solidThumbsUp),
                //     title: "Rate this app",//remove
                //     onTap: () {
                //
                //        Get.to(RateThisAppScreen());
                //     },
                //   );
                case 4:
                  return myDrawerTile(
                    icon: FaIcon(FontAwesomeIcons.wrench),
                    title: "Complaints",
                    onTap:  () async {
                      Get.to(NewComplaintScreen());
                    },
                  );
                  case 5:
                  return myDrawerTile(
                    icon: FaIcon(FontAwesomeIcons.rightFromBracket),
                    title: "Logout",
                    onTap:  () async {
                      bool shouldLogout = await showLogoutConfirmationDialog(context);
                      if (shouldLogout) {
                        AuthData().clearSharedPreferences();
                        Future.delayed(Duration(milliseconds: 200), () {
                          Get.offAll(LogInScreen());
                          print('logout');
                        });
                      }
                    },
                  );
              }
              return null;
            }),
      ),
    );
  }

  Widget myDrawerTile({
    required FaIcon icon,
    required String title,
    required Function onTap,

  }) {
    return Container(
      padding: EdgeInsets.only(left: 20,top: 10,bottom: 10),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Row(
          children: [
            icon,
            SizedBox(width: 10,),
            Text(
              title,
              style: grayTextStyle2,
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> showLogoutConfirmationDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Logout'),
          ),
        ],
      );
    },
  ) ?? false;
}
