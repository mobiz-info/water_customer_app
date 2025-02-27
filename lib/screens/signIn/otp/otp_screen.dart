import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/screens/signIn/new_password/new_password_screen.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_button.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
                  Image.asset('Assets/Images/LogIn/otp.png'),
                  SizedBox(height: screenHeight * .020),
                  Text(
                    'Verify OTP',
                    textAlign: TextAlign.center,
                    style: whiteHeadStyle2,
                  ),
                  SizedBox(height: screenHeight * .020),
                  Text(
                    'Please enter 4 digit code send to\nyour Email ',
                    style: whiteTextStyle2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * .050),
                  OtpTextField(
                    numberOfFields: 4,
                    fieldHeight: screenWidth*.125
                    ,fieldWidth: screenWidth*.125,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    borderColor: CustomColors.white,
                   borderRadius:  const BorderRadius.all(Radius.circular(15.0)),
                    filled: true,
                      fillColor:CustomColors.otpTextBoxColor,
                    decoration:const InputDecoration(
                    ),
          
                    showFieldAsBox: true,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode){
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: const Text("Verification Code"),
                              content: Text('Code entered is $verificationCode'),
                            );
                          }
                      );
                    }, // end onSubmit
                  ),
                  SizedBox(height: screenHeight * .020),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'If you don’t receive the code ? ', style: whiteTextStyle3),
                        TextSpan(text: 'Resend', style: whiteTextStyleBold3),
                      ],
                    ),),
                  SizedBox(height: screenHeight * .020),
                  CustomButton(
                    buttonText: 'VERIFY',
                    tapFunction: () {
                      Get.off(()=>const NewPasswordScreen());
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
