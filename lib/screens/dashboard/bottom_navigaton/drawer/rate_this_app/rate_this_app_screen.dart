import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';
import 'package:water_customer_app/widgets/custom_button.dart';
import 'package:water_customer_app/widgets/custom_text_area.dart';

class RateThisAppScreen extends StatefulWidget {
  const RateThisAppScreen({super.key});

  @override
  State<RateThisAppScreen> createState() => _RateThisAppScreenState();
}

class _RateThisAppScreenState extends State<RateThisAppScreen> {
  TextEditingController reasonController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return  Scaffold(
      appBar: CustomAppBar('Rate our app'),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' Your Feedback help us to Improve. ',
                style: grayTextStyle3,
              ),
          SizedBox(
            height: screenHeight*.01,),
        
              Text(
                '   Please let us know your experience',
                style: grayTextStyle1,
              ),
              SizedBox(
                height: screenHeight*.025,),
              CustomTextArea(controller: reasonController,borderColor: CustomColors.containerBorder,
              borderRadius: 22,),
              SizedBox(
                height: screenHeight*.05,),
              CustomButton(buttonText: 'Submit', tapFunction: (){Get.back();}, colorGradient: CustomColors.lightBlueGradient())
            ],
          ),
        ),
      ),

    );
  }
}
