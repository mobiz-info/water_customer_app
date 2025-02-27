import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/api/api_manager.dart';


class PauseMyDeliveryController extends GetxController {


  Future<void> PauseMyDelivery(String startDate,String endDate,String note) async {
    try {
      final status = await APIManager.PauseMyDelivery(startDate,endDate,note);
     if(status=='Done.'){
       Get.back();
       Fluttertoast.showToast(
         msg: "Delivery Paused",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
       );
     }
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      print('Error in PauseMyDelivery : $e');
    }
  }
}
