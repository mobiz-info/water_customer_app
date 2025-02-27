import 'package:flutter/material.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';
import 'package:water_customer_app/widgets/custom_button.dart';
import 'package:water_customer_app/widgets/custom_text_Field.dart';

class RechargeForOthersScreen extends StatelessWidget {
  const RechargeForOthersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TextEditingController customerIdController=TextEditingController();
    TextEditingController mobileNoController=TextEditingController();

    return  Scaffold(
      appBar: CustomAppBar('Recharge for others'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20,30,20,30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '  Beneficiary customer ID',
                  style: grayTextStyle1,
                ),
              ],
            ),
            SizedBox(height: screenHeight * .010),
            CustomTextField(
              label: '',
              color: CustomColors.text,
              borderColor: CustomColors.containerBorder,
              border: true,
              controller: customerIdController, textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * .020),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '  Beneficiary mobile number',
                  style: grayTextStyle1,
                ),
              ],
            ),
            SizedBox(height: screenHeight * .010),
            CustomTextField(
              label: '',
              color: CustomColors.text,
              borderColor: CustomColors.containerBorder,
              border: true,
              controller: mobileNoController, textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * .040),
            CustomButton(
              buttonText: 'Go',
              tapFunction: () {
                // Get.off(const LogInScreen());
              },
              colorGradient: CustomColors.lightBlueGradient(),
            ),
            SizedBox(height: screenHeight * .060)

          ],
        ),
      ),

    );
  }
}
