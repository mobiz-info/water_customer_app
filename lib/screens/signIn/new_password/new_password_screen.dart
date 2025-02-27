import 'package:flutter/material.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_button.dart';
import 'package:water_customer_app/widgets/custom_text_Field.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController newPasswordController=TextEditingController();
    TextEditingController confirmPasswordController=TextEditingController();

    return Container(
      decoration: const BoxDecoration(color: CustomColors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(gradient: CustomColors.lightBlueGradient()),

            child: Center(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * .15),
                  Image.asset('Assets/Images/LogIn/password.png'),
                  SizedBox(height: screenHeight * .050),
                  Container(
                    padding: const EdgeInsets.all(40),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      color: CustomColors.white
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Centers entire Column
                      children: [
                        Text(
                          'Create New Password',
                          textAlign: TextAlign.center,
                          style: grayHeadStyle2,
                        ),
                        SizedBox(height: screenHeight * .010),
                        Text(
                          'New Password must be different from\npreviously used password',
                          style: grayTextStyle1,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: screenHeight * .030),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'New Password',
                              style: grayTextStyle1,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * .010),
                         CustomTextField(
                          label: '',
                          color: CustomColors.text,
                          borderColor: CustomColors.text,
                          border: true,
                           controller: newPasswordController, textAlign: TextAlign.left,
                        ),
                        SizedBox(height: screenHeight * .020),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Confirm Password',
                              style: grayTextStyle1,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * .010),
                         CustomTextField(
                          label: '',
                          color: CustomColors.text,
                          borderColor: CustomColors.text,
                          border: true,
                           controller: confirmPasswordController, textAlign: TextAlign.left,
                        ),
                        SizedBox(height: screenHeight * .040),
                        CustomButton(
                          buttonText: 'Reset Password',
                          tapFunction: () {
                            // Get.off(const LogInScreen());
                          },
                          colorGradient: CustomColors.lightGreenGradient(),
                        ),
                        SizedBox(height: screenHeight * .060)

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
