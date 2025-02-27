import 'package:flutter/material.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';
import 'package:water_customer_app/widgets/custom_button.dart';
import 'package:water_customer_app/widgets/custom_text_Field.dart';
import 'package:water_customer_app/widgets/custom_text_area.dart';

class FeedbackScreen extends StatefulWidget {
   FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return  Scaffold(
      appBar: CustomAppBar('Your feedback'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomTextArea(controller: categoryController,label: 'Type your feedback',),
           SizedBox(height:  screenHeight*.02),
            CustomButton(buttonText: 'Submit', tapFunction: (){},
                colorGradient: CustomColors.lightBlueGradient())
        
            ],
          ),
        ),
      ),

    );
  }
}
