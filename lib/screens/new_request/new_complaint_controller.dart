import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/api/api_manager.dart';


class NewComplaintController extends GetxController {
  Future<void> newComplaint(String message) async {
    try {
      final status = await APIManager.postComplaint(message);
     if(status=='Done.'){
       Fluttertoast.showToast(
         msg: "Complaint Placed",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
       );
     }
    } catch (e) {
      log(e.toString());
      print('Error in salesmanRequest : $e');
    }
  }
}
