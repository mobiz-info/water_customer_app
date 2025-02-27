import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/Models/order_water_response_model.dart';
import 'package:water_customer_app/api/api_manager.dart';

class OrderPlaceController extends GetxController{


  RxDouble totalAmount = 0.0.obs;
  RxBool isLoading = false.obs;
  RxBool cashOnDeliveryStatus = true.obs;
  OrderWaterResponseModel? orderWaterResponseModel;
  void updateTotalAmount(String count ,double rate) {
    totalAmount.value = ((int.parse(count)) * (rate));
  }
  Future<void> orderWater(
      String deliveryDate,
      String productId,
      int quantity,

      ) async {
    try {
      isLoading.value = true;
      orderWaterResponseModel =
      await APIManager.orderWaterPost(
          productId,
          deliveryDate,
          quantity,
          totalAmount.value,
          0,
          false,
          0,
          0.0,
          totalAmount.value,
          cashOnDeliveryStatus.value == true ?'cod':'online'
      );

      if (orderWaterResponseModel is OrderWaterResponseModel) {
        Get.back();
        // Handle the "Invalid credentials" case
        Fluttertoast.showToast(
          msg: "Order Placed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Error !!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
        );
      }
    } catch (e) {
      log(e.toString());
      print('Error00004: $e');

      isLoading.value = false;
    }
  }
}