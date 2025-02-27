import 'dart:developer';

import 'package:get/get.dart';
import 'package:water_customer_app/Models/cooler_purchase_response_model.dart';
import 'package:water_customer_app/Models/coupon_purchase_response_model.dart';
import 'package:water_customer_app/api/api_manager.dart';

class PurchaseController extends GetxController{
  RxBool isLoading =false.obs;
  CoolerPurchaseResponseModel? coolerPurchaseResponseModel;
  CouponPurchaseResponseModel? couponPurchaseResponseModel;

  Future<void>getCoolerPurchase()async{
    try{
      isLoading.value=true;
      coolerPurchaseResponseModel= await APIManager.getCoolerPurchase();
      if(coolerPurchaseResponseModel is CoolerPurchaseResponseModel){
        if(coolerPurchaseResponseModel?.orders != null){
print('test1');
        }
      }
    }catch (e) {
      log(e.toString());
      print('Error1: $e');


    } isLoading.value = false;
  }
  Future<void>getWaterBottlePurchase()async{
    try{
      isLoading.value=true;
      coolerPurchaseResponseModel= await APIManager.getWaterBottlePurchase();
      if(coolerPurchaseResponseModel is CoolerPurchaseResponseModel){
        if(coolerPurchaseResponseModel?.orders != null){
print('test2');
        }
      }
    }catch (e) {
      log(e.toString());
      print('Error2: $e');


    } isLoading.value = false;
  }
  Future<void>getCouponPurchase()async{
    try{
      isLoading.value=true;
      couponPurchaseResponseModel= await APIManager.getCouponPurchase();
      if(couponPurchaseResponseModel is CouponPurchaseResponseModel){
        if(couponPurchaseResponseModel?.couponList != null){
print('test3');
        }
      }
    }catch (e) {
      log(e.toString());
      print('Error3: $e');


    } isLoading.value = false;
  }
}