import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/screens/signIn/log_in/log_in_screen.dart';
import 'package:water_customer_app/utils/Common.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:CustomColors.lightBlueGradient()
      ),
      child:  Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,// Centers entire Column
              children: [
                // baseUrl == "http://68.183.94.11:881"
                //     ? Image.asset('Assets/Images/sanaWaterLogo.png')
                //     : baseUrl =="http://68.183.94.11:91"? Image.asset('Assets/Images/nationalWaterLogo.png'):
                //

                Image.asset(logoPath)
                ,
                //('Assets/Images/LogIn/nationalLogo.png'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to  ',
                          style: whiteTextStyle2,
                        ),
                        Text(
                        appName,
                          style: whiteHeadStyle1,
                        ),
                        Text(
                          ' ',
                          style: whiteTextStyle2,
                        ),
                      ],

                    ),const SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end
                      ,
                      children: [
                        Text(
                          '',
                          style: whiteTextStyle2,
                        ),
                        Text(
                          'Waters',
                          style: whiteHeadStyle1,
                        ),
                        Text(
                          'Water is life...',
                          style: whiteTextStyle2,
                        ),
                      ],

                    ),
                  ],
                ),
               const SizedBox(height: 50),
                CustomButton(buttonText: 'GET STARTED', tapFunction: (){
                  Get.off( LogInScreen());
                }, colorGradient: CustomColors.lightGreenGradient(),gradiant: true,)
          ,const SizedBox(height: 80)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
