import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/Models/list_cart_response_model.dart';
import 'package:water_customer_app/Models/order_water_response_model.dart';
import 'package:water_customer_app/api/api_manager.dart';
import 'package:water_customer_app/utils/Common.dart';
import 'package:water_customer_app/utils/globals.dart' as globals;

class OrderWaterController extends GetxController {

  // String productId='2bd3d3d2-dc8b-4e73-8f7e-d828846c9710';
  // RxDouble rate = 7.0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxDouble totalNetAmount = 00.00.obs;
  RxBool requiredEmptyBottleStatus = false.obs;
  RxBool cashOnDeliveryStatus = true.obs;
  RxBool isLoading = false.obs;
  OrderWaterResponseModel? orderWaterResponseModel;
  RxBool isLoadingCart = false.obs;
  RxString selectedProductId = ''.obs;
  ListCartResponseModel? listCartResponseModel;
  RxBool isLoadingProductList = false.obs;

  void updateTotalAmount(String bottleCount) {
    totalAmount.value = (int.parse(bottleCount)) *  globals.waterRate;
    if ( AuthData().sales_type == 'FOC'){
      totalAmount.value=0.0;
    }
  }



  Future<void> orderWater(
      String deliveryDate,
      int quantity,
      double totalAmount,
      int noEmptyBottleReturn,
      int noEmptyBottleRequired,
      double emptyBottleAmount,
      double totalNetAmount,
       ) async {
    try {
      isLoading.value = true;
      orderWaterResponseModel =
          await APIManager.orderWaterPost(
              globals.waterId,
              deliveryDate,
              quantity,
              totalAmount,
              noEmptyBottleReturn,
              requiredEmptyBottleStatus.value,
              noEmptyBottleRequired,
              emptyBottleAmount,
              totalNetAmount,
              cashOnDeliveryStatus.value==true?'cod':'online'
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
  Future<void> addToCart(String date,int quantity,double price,) async {
    try {
      isLoadingCart.value = true;
      selectedProductId.value =  globals.waterId;
      final response = await APIManager.addToCart(date, globals.waterId,quantity,price);
      if (response
          == 'Done.') {
        Get.back();
        // Handle the "Invalid credentials" case
        Fluttertoast.showToast(
          msg: "Add to Cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        await listTheCart();

        isLoadingCart.value = false;
      }
    } catch (e) {
      log(e.toString());
      print('Error coupon: $e');
    }finally {
      selectedProductId.value = ''; // Reset after API call is complete
      isLoadingCart.value = false;
    }
  }
  Future<void> listTheCart() async {
    try {
      isLoadingCart.value = true;
      listCartResponseModel = await APIManager.listTheCart();
      if (listCartResponseModel
      is ListCartResponseModel) {
        print(listCartResponseModel?.data);
        print('Cart items:');
        for (var item in listCartResponseModel?.data.items??[]) {
          print('Product: ${item.product}, Quantity: ${item.quantity}, Price: ${item.price}');
        }
        if (listCartResponseModel
        is ListCartResponseModel) {

          globals.cartList?.clear();
          globals.cartList=listCartResponseModel?.data.items;

          isLoadingProductList.value = false;
        }

        isLoadingCart.value = false;
      }
    } catch (e) {
      log(e.toString());
      print('Error coupon: $e');
    }
  }
  bool isProductInCart(String productId) {
    if ( globals.cartList == null ||  globals.cartList!.isEmpty) {
      print('cart is null !!!!!!!!!!!! ');
      return false;
    }

    print('cart has items ............ ');
    print(globals.cartList);
    return globals.cartList!.any((cartItem) => cartItem.productId == productId);
  }
}
