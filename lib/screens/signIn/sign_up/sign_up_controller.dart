import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/Models/emirate_location_model.dart';
import 'package:water_customer_app/Models/parser_helper/parser_helper.dart';
import 'package:water_customer_app/api/api_manager.dart';
import 'package:water_customer_app/utils/globals.dart' as globals;

class SignUpController extends GetxController{
  EmirateLocationModel? emirateLocationModel;
  var selectedEmirate = ''.obs;
  var selectedLocation = ''.obs;
  RxBool locationLoading = false.obs;
  RxList<EmirateLocationData> emiratesList = <EmirateLocationData>[].obs;
  RxList<Locations> locationsList = <Locations>[].obs;
  final RxMap<String, String> errors = <String, String>{}.obs;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mailIdController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController floorNoController = TextEditingController();
  TextEditingController roomNoController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController bottleCountController = TextEditingController();

  bool validateFields() {
    errors.clear();

    if (fullNameController.text.trim().isEmpty) errors['fullName'] = 'Full Name is required';
    if (buildingNameController.text.trim().isEmpty) errors['buildingName'] = 'Building Name is required';
    if (floorNoController.text.trim().isEmpty) errors['floorNo'] = 'Floor No is required';
    if (roomNoController.text.trim().isEmpty) errors['roomNo'] = 'Room No is required';
    if (mobileNoController.text.trim().isEmpty) errors['mobileNo'] = 'Mobile No is required';
    if (bottleCountController.text.trim().isEmpty) errors['bottleCount'] = 'Bottle Count is required';
    if (selectedEmirate.value.trim().isEmpty) errors['emirate'] = 'Emirate selection is required';
    if (selectedLocation.value.trim().isEmpty) errors['location'] = 'Location selection is required';
    if (getSelectedDays().isEmpty) errors['days'] = 'At least one day selection is required';
    print("Errors found: $errors");
    return errors.isEmpty;
  }

  final isSelected = RxList<bool>.filled(7, false); // 7 days in a week

  void toggleCircle(int day) {
    isSelected[day] = !isSelected[day];
    isSelected.refresh(); // Notify the UI of the change
  }
  List<String> getSelectedDays() {
    final daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    List<String> selectedDays = [];

    for (int day = 0; day < isSelected.length; day++) {
      if (isSelected[day]) {
        selectedDays.add(daysOfWeek[day]);
      }
    }
    return selectedDays;
  }
  Future<void> getEmirateLocation(String username,String password) async{

    try {
      emirateLocationModel = await APIManager.getEmirateLocation( username, password);

      if (emirateLocationModel is EmirateLocationModel) {
        if (emirateLocationModel?.data != null) {
          globals.emirate=emirateLocationModel?.data;
          emiratesList.assignAll(emirateLocationModel!.data!);
        }
      }
    } catch (e) {
      log(e.toString());
      print('Error Emirate Location: $e');
    }
  }


  void onEmirateSelected(String emirateId) {
    locationLoading.value=true;
    selectedEmirate.value = emirateId;
    locationsList.clear();
    locationsList.assignAll(
      emiratesList.firstWhere((e) => e.emirateId == emirateId).locations ?? [],
    );
    selectedLocation.value = '';
    print('Error Emirate Location: 0000000000000000000000');
    locationLoading.value=false;

  }

  Future<void> newCustomerRegistration() async {
    try {
      final status = await APIManager.postCustomerRegistration(
        fullNameController.text,mobileNoController.text,
        buildingNameController.text,
        roomNoController.text,
          selectedLocation.value,
          selectedEmirate.value,

          getSelectedDays(),
          parseInt(bottleCountController.text )??0
      );
      if(status=='Done'){
        Fluttertoast.showToast(
          msg: "Registration Placed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );

      }else{
        Fluttertoast.showToast(
          msg: "Something went wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    } catch (e) {
      log(e.toString());
      print('Error in Registration : $e');
    }
    Get.back();
  }

}