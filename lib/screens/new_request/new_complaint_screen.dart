import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/screens/new_request/new_complaint_controller.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';
import 'package:water_customer_app/widgets/custom_button.dart';


class NewComplaintScreen extends StatefulWidget {
  const NewComplaintScreen({Key? key}) : super(key: key);

  @override
  _NewComplaintScreenState createState() => _NewComplaintScreenState();
}

class _NewComplaintScreenState extends State<NewComplaintScreen> {
  String selectedType = 'Select Type'; // Track the selected dropdown value
  TextEditingController remarkTextController = TextEditingController();
  NewComplaintController newComplaintController = NewComplaintController();
  @override
  Widget build(BuildContext context) {
    double widthsize = MediaQuery.of(context).size.width;
    double heightsize = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar('New Complaint'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(15.0),
                width: widthsize,
                // height: heightsize * 0.40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // gradient: CustomColors.darkBlueGradient(),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 15.0),
                        padding: const EdgeInsets.all(15.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          border: Border.all(
                          width: 1.0, // Set the border width to 1 pixel
                          color: Colors.grey, // Choose your desired border color
                        ),
                          // gradient: CustomColors.lightBlueGradient(),
                        ),
                        height: heightsize * 0.15,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0), // Add horizontal padding
                          child: TextField(
                            minLines: 25,
                            controller: remarkTextController,
                            decoration: InputDecoration(
                              hintText: "Complaints",
                              hintStyle: TextStyle(
                                  color: Colors.grey), // Text color of hint
                              border: InputBorder.none, // Remove the border
                            ),
                            style: TextStyle(
                                color: Colors.black), // Text color of input
                            maxLines: null, // Allow multiple lines for remarks
                          ),
                        ),
                      ),
                    ),
                    CustomButton(
                        buttonText: 'Submit',
                        tapFunction: () {
                          if (remarkTextController.text != "") {
                            newComplaintController
                                .newComplaint(remarkTextController.text);
                            Get.back();
                          } else {
                            Fluttertoast.showToast(
                              msg: "Blank request",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                            );
                            // CustomSnackbar.show(
                            //     title: "Warning!!!",
                            //     message: "Complaint is empty.",
                            //     backgroundColor:
                            //     CustomColors.snackBarErrorColor);
                          }
                        },
                        colorGradient: CustomColors.lightBlueGradient())
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
