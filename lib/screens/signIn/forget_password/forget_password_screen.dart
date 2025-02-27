import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/screens/signIn/otp/otp_screen.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_button.dart';
import 'package:water_customer_app/widgets/custom_text_Field.dart';

class ForgetPasswordScree extends StatelessWidget {
  const ForgetPasswordScree({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController mailIdController=TextEditingController();

    return Container(
      decoration: BoxDecoration(gradient: CustomColors.lightBlueGradient()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                // Centers entire Column
                children: [
                  SizedBox(height: screenHeight * .2),
                  Image.asset('Assets/Images/LogIn/forgotPassword.png'),
                  SizedBox(height: screenHeight * .020),
                  Text(
                    'Forget Password ?',
                    textAlign: TextAlign.center,
                    style: whiteHeadStyle2,
                  ),
                  SizedBox(height: screenHeight * .020),
                  Text(
                    'Please enter your Email address to\n receive a verification code',
                    style: whiteTextStyle2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * .050),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Email address',
                        style: whiteTextStyle2,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * .020),
                   CustomTextField(
                    label: '',
                    color: CustomColors.white,
                    borderColor: CustomColors.white,
                    border: true,
                    controller: mailIdController,
                     textAlign: TextAlign.left,
                  ),
                  SizedBox(height: screenHeight * .020),
                  CustomButton(
                    buttonText: 'SEND EMAILD',
                    tapFunction: () {
                       Get.off(const OtpScreen());
                    },
                    colorGradient: CustomColors.lightGreenGradient(),
                  ),
                  const SizedBox(height: 80)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
