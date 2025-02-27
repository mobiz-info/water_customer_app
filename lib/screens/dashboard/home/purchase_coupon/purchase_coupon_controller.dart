import 'dart:developer';

import 'package:get/get.dart';
import 'package:water_customer_app/Models/coupon_list_response_model.dart';
import 'package:water_customer_app/Models/list_cart_response_model.dart';
import 'package:water_customer_app/Models/product_List_response_model.dart';
import 'package:water_customer_app/api/api_manager.dart';
import 'package:water_customer_app/utils/globals.dart' as globals;


class PurchaseCouponController extends GetxController{



  RxBool isLoadingProductList = false.obs;
  RxBool isLoadingCart = false.obs;
  CouponListResponseModel? couponListResponseModel;
  ListCartResponseModel? listCartResponseModel;
  RxList<CartItem> cartList = <CartItem>[].obs;

  Future<void> getCouponList() async {
    try {
      isLoadingProductList.value = true;
      couponListResponseModel = await APIManager.getCouponList();
      if (couponListResponseModel
      is CouponListResponseModel) {
        print(couponListResponseModel?.data);
        isLoadingProductList.value = false;
      }
    } catch (e) {
      log(e.toString());
      print('Error coupon: $e');
    }
  }
  Future<void> addToCart(String date,String productId,int quantity,double price,) async {
    try {
      isLoadingCart.value = true;
      final response = await APIManager.addToCart(date,productId,quantity,price);
      if (response
      == 'Done.') {
       await listTheCart();
       couponListResponseModel?.data?.forEach((coupon) {
         if (coupon.id == productId) {
           coupon.isProductInCart.value = true;
         }
       });
        isLoadingCart.value = false;
      }
    } catch (e) {
      log(e.toString());
      print('Error coupon: $e');
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
          cartList.clear();
          cartList.addAll(listCartResponseModel?.data.items ?? []);
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
      print('cart is null !!!!!!!!!!!! $productId');
      return false;
    }

    print('cart has items ............ ');
    print(globals.cartList);
    return globals.cartList!.any((cartItem) => cartItem.productId == productId);
  }
  Future<void> deleteTheCart(String productId) async {
    try {

      isLoadingCart.value = true;
      final response = await APIManager.deleteTheCart(productId);
      if (response
          == 'Done.') {
        await listTheCart();
        couponListResponseModel?.data?.forEach((coupon) {
          if (coupon.id == productId) {
            coupon.isProductInCart.value = false; // Set to false since the item is removed
          }
        });
        isLoadingCart.value = false;
      }
    } catch (e) {
      log(e.toString());
      print('Error coupon: $e');
    }
  }
}