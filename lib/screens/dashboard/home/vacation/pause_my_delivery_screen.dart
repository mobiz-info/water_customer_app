import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:water_customer_app/screens/dashboard/home/vacation/pause_my_delivery_controller.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';
import 'package:water_customer_app/widgets/custom_button.dart';
import 'package:water_customer_app/widgets/custom_text_area.dart';

class PauseMyDeliveryScreen extends StatefulWidget {
  PauseMyDeliveryScreen({super.key});

  @override
  State<PauseMyDeliveryScreen> createState() => _PauseMyDeliveryScreenState();
}

class _PauseMyDeliveryScreenState extends State<PauseMyDeliveryScreen> {
  PauseMyDeliveryController pauseMyDeliveryController = Get.put(PauseMyDeliveryController());
  TextEditingController reasonController = TextEditingController();

  DateTime selectedDateStart = DateTime.now();
  DateTime selectedDateEnd = DateTime.now();

  final DateFormat displayFormatter = DateFormat('dd-MM-yyyy');
  final DateFormat functionFormatter = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateStart,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDateStart) {
      setState(() {
        selectedDateStart = picked;
      });
    }
  }

  // Function to pick the end date
  Future<void> _selectDateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateEnd,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDateEnd) {
      setState(() {
        selectedDateEnd = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar('Pause my delivery'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: screenHeight * .03),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: CustomColors.containerBorder),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Start Date',
                          style: grayTextStyle2,
                          textAlign: TextAlign.center,
                        ),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: CustomColors.datePickerBg,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.calendar_today,
                                      color: CustomColors.text),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      displayFormatter.format(selectedDateStart), // Display in dd-MM-yyyy
                                      style: TextStyle(color: CustomColors.text),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * .01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select End Date',
                          style: grayTextStyle2,
                          textAlign: TextAlign.center,
                        ),
                        GestureDetector(
                          onTap: () => _selectDateEnd(context),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: CustomColors.datePickerBg,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.calendar_today,
                                      color: CustomColors.text),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      displayFormatter.format(selectedDateEnd), // Display in dd-MM-yyyy
                                      style: TextStyle(color: CustomColors.text),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                '  Tell Us Why You Want to Pause',
                style: grayTextStyle2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: screenHeight * .01,
              ),
              CustomTextArea(
                controller: reasonController,
                borderColor: CustomColors.containerBorder,
              ),
              SizedBox(
                height: screenHeight * .01,
              ),
              CustomButton(
                buttonText: 'Submit',
                tapFunction: () {
                  pauseMyDeliveryController.PauseMyDelivery(
                    functionFormatter.format(selectedDateStart),
                    functionFormatter.format(selectedDateEnd),
                    reasonController.text,
                  );
                },
                colorGradient: CustomColors.lightBlueGradient(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
