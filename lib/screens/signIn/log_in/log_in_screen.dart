import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/screens/dashboard/bottom_navigaton/bottom_navigation_bar_screen.dart';
import 'package:water_customer_app/screens/signIn/forget_password/forget_password_screen.dart';
import 'package:water_customer_app/screens/signIn/log_in/log_in_controller.dart';
import 'package:water_customer_app/screens/signIn/sign_up/sign_up_screen.dart';
import 'package:water_customer_app/utils/Common.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_button.dart';
import 'package:water_customer_app/widgets/custom_text_Field.dart';

class LogInScreen extends StatefulWidget {
   LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController urlController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  LogInController logInController = LogInController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        color: CustomColors.white,
        image: DecorationImage(
          image: AssetImage('Assets/Images/LogIn/signInBg.png'),
          // Replace with your image path
          fit: BoxFit.none, // Adjust fit as needed (cover, fill, etc.)
        ),
      ),
      child: Scaffold(
        backgroundColor: CustomColors.whiteOP,
        body: Stack(
          children: [ SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: screenHeight * .2,
                  // ),
                  // Text(
                  //   'URL',
                  //   style: grayHeadStyle1,
                  // ),
                  // SizedBox(height: screenHeight * .2),
                  // CustomTextField(
                  //   icon: Icons.person,
                  //   label: 'http://',
                  //   color: CustomColors.text,
                  //   borderColor: CustomColors.textBoxBorderColor,
                  //   border: true,
                  //   controller: urlController, textAlign: TextAlign.left,
                  // ),
                  // SizedBox(height: screenHeight * .020),
                  // CustomButton(
                  //   buttonText: 'Set URL',
                  //   tapFunction: () {
                  //     print(baseUrl);
                  //     baseUrl=urlController.text;
                  //     print(baseUrl);
                  //   },
                  //   colorGradient: CustomColors.lightGreenGradient(),
                  // ),
                  SizedBox(
                    height: screenHeight * .2,
                  ),
                  Text(
                    'Log In',
                    style: grayHeadStyle1,
                  ),
                  SizedBox(height: screenHeight * .2),
                  CustomTextField(
                    icon: Icons.person,
                    label: 'Username',
                    color: CustomColors.text,
                    borderColor: CustomColors.textBoxBorderColor,
                    border: true,
                    controller: userNameController, textAlign: TextAlign.left,
                  ),
                  SizedBox(height: screenHeight * .020),
                  passwordTextField(
                      passwordController,
                      Icons.remove_red_eye,
                      CustomColors.text,
                    'Password',
                  ),
                  SizedBox(height: screenHeight * .020),

                  CustomButton(
                    buttonText: 'LogIn',
                    tapFunction: () {
                      logInController.isCredentialValid(
                          userNameController.text, passwordController.text);
                    },
                    colorGradient: CustomColors.lightGreenGradient(),
                  ),
                  SizedBox(height: screenHeight * .020),
                  // GestureDetector(
                  //     onTap: () {
                  //       Get.to(() => const ForgetPasswordScree());
                  //     },
                  //     child: Text(
                  //       'Forget Password ?',
                  //       style: grayTextStyleBold1,
                  //     )),
                  SizedBox(height: screenHeight * .020),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Don’t have an account? ',
                            style: grayTextStyle1),
                        TextSpan(
                          text: ' Sign Up',
                          style: grayTextStyleBold1,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => const SignUpScreen());
                            },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),],
        ),
      ),
    );
  }
  Widget passwordTextField(TextEditingController controller,IconData icon,Color color,String label)
  {
    return Obx(
        ()=> Container(
        padding: const EdgeInsets.only(right: 15,bottom: 5,left: 15),
        decoration:  BoxDecoration(
          borderRadius:BorderRadius.circular(22),
          border: Border.all(color: CustomColors.textBoxBorderColor ?? Colors.grey),
        )
            ,
        child: TextField(
            textAlign: TextAlign.left,
            controller: controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(

              prefixIcon: IconButton(
                icon: Icon(
                  logInController.isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () => logInController.togglePasswordVisibility(),
              ),
              labelText: label,
              labelStyle: TextStyle(

                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: color,
                  fontFamily: 'Poppins'),

              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),obscureText: !logInController.isPasswordVisible.value,

        ),
      ),
    );
  }
}
