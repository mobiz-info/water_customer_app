import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/Models/list_cart_response_model.dart';
import 'package:water_customer_app/api/api_manager.dart';
import 'package:water_customer_app/utils/globals.dart' as globals;

class CartController extends GetxController{
  RxBool isLoadingCart = false.obs;
  RxBool isLoadingProductList = false.obs;
  RxBool isLoadingOrderPlace = false.obs;
  ListCartResponseModel? listCartResponseModel;
  RxList<CartItem> cartList = <CartItem>[].obs;
  RxString grandTotal=''.obs;


  Future<void> deleteTheCart(String productId) async {
    try {
      isLoadingCart.value = true;
      final response = await APIManager.deleteTheCart(productId);
      if (response
          == 'Done.') {
        await listTheCart();
        isLoadingCart.value = false;
      }
    } catch (e) {
      log(e.toString());
      print('Error coupon: $e');
    }
  }
  Future<void> listTheCart() async {
    try {
      isLoadingProductList.value = true;
      listCartResponseModel = await APIManager.listTheCart();
      if (listCartResponseModel
      is ListCartResponseModel) {
        grandTotal.value=listCartResponseModel?.data.grandTotal ??'0';
        cartList.clear();
        cartList.addAll(listCartResponseModel?.data.items ?? []);
        globals.cartList?.clear();
        globals.cartList=listCartResponseModel?.data.items;

      }
    } catch (e) {
      log(e.toString());
      print('Error coupon: $e');
    }
    isLoadingProductList.value = false;
  }
  Future<void> placeOrder() async {
    try {
      isLoadingOrderPlace.value = true;
     final response = await APIManager.placeOrder(listCartResponseModel?.data.id ??'');
      if (response
          == 'Done.') {
         listTheCart();
         cartList.clear();
         globals.cartList?.clear();
        Fluttertoast.showToast(
          msg: "Your Order placed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        isLoadingOrderPlace.value = false;
      }
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      print('Error coupon: $e');
    }
  } Future<void> editOrder(String productCartId,int quantity) async {
    try {
     final listCartResponseModel = await APIManager.editOrder(productCartId,quantity);
     if (listCartResponseModel
     is ListCartResponseModel) {
       grandTotal.value=listCartResponseModel?.data.grandTotal ??'0';
       cartList.clear();
       cartList.addAll(listCartResponseModel?.data.items ?? []);
       isLoadingProductList.value = false;
      }
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      print('Error edit: $e');
    }
  }
}