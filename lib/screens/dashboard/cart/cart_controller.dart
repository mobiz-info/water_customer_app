import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  RxString deliveryDate=''.obs;

  //created by new
  // RxList<CartData> allCarts = <CartData>[].obs;


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


  //created by abhijth
  Future<void> listTheCart() async {
    try {
      isLoadingProductList.value = true;
      listCartResponseModel = await APIManager.listTheCart();
      if (listCartResponseModel
      is ListCartResponseModel) {
        grandTotal.value=listCartResponseModel?.data.grandTotal ??'0';
        deliveryDate.value=listCartResponseModel?.data.deliveryDate ??'0';

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
  //craeted by new for api response changes
  // Future<void> listTheCart() async {
  //   try {
  //     isLoadingProductList.value = true;
  //     listCartResponseModel = await APIManager.listTheCart();
  //     if (listCartResponseModel is ListCartResponseModel) {
  //       allCarts.value = listCartResponseModel?.data ?? [];
  //
  //       // For backward compatibility, you might want to:
  //       // 1. Use the first cart (if exists) or create a new one
  //       // 2. Combine all items from all carts
  //
  //       // Option 1: Use first cart
  //       if (allCarts.isNotEmpty) {
  //         grandTotal.value = allCarts.first.grandTotal ?? '0';
  //         cartList.value = allCarts.first.items;
  //         globals.cartList = allCarts.first.items;
  //       } else {
  //         grandTotal.value = '0';
  //         cartList.clear();
  //         globals.cartList?.clear();
  //       }
  //
  //
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //     print('Error coupon: $e');
  //   }
  //   isLoadingProductList.value = false;
  // }
  //created by new for api response changes

  // Future<void> placeOrder() async {
  //   try {
  //     isLoadingOrderPlace.value = true;
  //     // You need to decide which cart to place order for
  //     // Here we're using the first cart (if exists)
  //     if (allCarts.isNotEmpty) {
  //       final response = await APIManager.placeOrder(allCarts.first.id ?? '');
  //       if (response == 'Done.') {
  //         await listTheCart();
  //         cartList.clear();
  //         globals.cartList?.clear();
  //         Fluttertoast.showToast(
  //           msg: "Your Order placed",
  //           toastLength: Toast.LENGTH_LONG,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.green,
  //           textColor: Colors.white,
  //         );
  //         isLoadingOrderPlace.value = false;
  //       }
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //     Fluttertoast.showToast(
  //       msg: "$e",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //     );
  //     print('Error coupon: $e');
  //   }
  // }
  //created by abhijith
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
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,

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
  }



  //created by new for api response changes
  // Future<void> editOrder(String productCartId, int quantity) async {
  //   try {
  //     final response = await APIManager.editOrder(productCartId, quantity);
  //     if (response is ListCartResponseModel) {
  //       allCarts.value = response.data;
  //
  //       // Update the first cart (or whichever cart you're working with)
  //       if (allCarts.isNotEmpty) {
  //         grandTotal.value = allCarts.first.grandTotal ?? '0';
  //         cartList.value = allCarts.first.items;
  //       }
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //     Fluttertoast.showToast(
  //       msg: "$e",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //     );
  //     print('Error edit: $e');
  //   }
  // }
  //created by abhijith
  Future<void> editOrder(String productCartId,int quantity) async {
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