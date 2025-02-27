import 'package:flutter/material.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';
import 'package:water_customer_app/widgets/custom_text_Field.dart';
import 'package:water_customer_app/widgets/custom_text_area.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController alternativePhoneNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController zoneController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();
  TextEditingController landPhoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar('My profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomTextField(
                controller: nameController,
                label: 'Name',
                border: true,
                borderColor: CustomColors.containerBorder,
                borderRadius: 22, textAlign: TextAlign.left,
              ),
              SizedBox(
                height: screenHeight * .01,
              ),
              CustomTextField(
                controller: emailController,
                label: 'Email',
                border: true,
                borderColor: CustomColors.containerBorder,
                borderRadius: 22, textAlign: TextAlign.left,
              ),
              SizedBox(
                height: screenHeight * .01,
              ),
              CustomTextField(
                controller: phoneNoController,
                label: 'Mobile',
                border: true,
                borderColor: CustomColors.containerBorder,
                borderRadius: 22, textAlign: TextAlign.left,
              ),
              SizedBox(
                height: screenHeight * .01,
              ),
              CustomTextField(
                controller: alternativePhoneNoController,
                label: 'nameController',
                border: true,
                borderColor: CustomColors.containerBorder,
                borderRadius: 22, textAlign: TextAlign.left,
              ),
              SizedBox(
                height: screenHeight * .01,
              ),
              CustomTextArea(
                controller: addressController,
                label: 'Address',
                border: true,
                borderColor: CustomColors.containerBorder,
                borderRadius: 22,
              ),
              SizedBox(
                height: screenHeight * .01,
              ),
              CustomTextField(
                controller: zoneController,
                label: 'Zone',
                border: true,
                borderColor: CustomColors.containerBorder,
                borderRadius: 22, textAlign: TextAlign.left,
              ),
              SizedBox(
                height: screenHeight * .01,
              ),
              CustomTextField(
                controller: landMarkController,
                label: 'Nearest Landmark',
                border: true,
                borderColor: CustomColors.containerBorder,
                borderRadius: 22, textAlign: TextAlign.left,
              ),
              SizedBox(
                height: screenHeight * .01,
              ),
              CustomTextField(
                controller: landPhoneNoController,
                label: 'Landline number',
                border: true,
                borderColor: CustomColors.containerBorder,
                borderRadius: 22, textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
