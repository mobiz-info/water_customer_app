import 'dart:developer';

import 'package:get/get.dart';
import 'package:water_customer_app/Models/balance_coupon_response_model.dart';
import 'package:water_customer_app/Models/list_cart_response_model.dart';
import 'package:water_customer_app/Models/my_outstanding_response_mdel.dart';
import 'package:water_customer_app/Models/next_visit_date_response_model.dart';
import 'package:water_customer_app/api/api_manager.dart';
import 'package:water_customer_app/utils/globals.dart' as globals;

class HomeController extends GetxController{
  NextVisitDateResponseModel? nextVisitDateResponseModel;
  BalanceCouponResponseModel? balanceCouponResponseModel;
  MyOutStandingResponseModel? myOutStandingResponseModel;
  ListCartResponseModel? listCartResponseModel;
  RxBool isLoading= false.obs;
  RxString nextVisitDate= ''.obs;
  RxString couponBalance= ''.obs;
  RxString bottleConceptionCount= ''.obs;
  RxString outstandingCouponBalance= ''.obs;
  RxString outstandingCanBalance= ''.obs;
  RxString outstandingCashBalance= ''.obs;
  RxInt selectedIndex = (-1).obs;

  Future<void>getNextVisitDate()async{
    try{
      isLoading.value=true;
      nextVisitDateResponseModel= await APIManager.getNextVisitDate();
      if(nextVisitDateResponseModel is NextVisitDateResponseModel){


      if((nextVisitDateResponseModel?.data) != null){
        nextVisitDate.value= nextVisitDateResponseModel!.data.toString();
       globals.nextDeliveryDate=nextVisitDateResponseModel!.data;


      }else{
        nextVisitDate.value='No data Available';

      }
      }
    }catch (e) {
      log(e.toString());
      print('Error00002: $e');

      isLoading.value = false;
    }
  }Future<void>getCouponBalance()async{
    try{
      isLoading.value=true;
      balanceCouponResponseModel= await APIManager.getCouponBalance();
      if(balanceCouponResponseModel is BalanceCouponResponseModel){
      if(balanceCouponResponseModel?.data != null){
        couponBalance.value= ((balanceCouponResponseModel!.data!.digitalCoupons??0)+(balanceCouponResponseModel!.data!.manualCoupons??0)).toString();
        print(balanceCouponResponseModel!.data!.bottleConceptionCount??00);
        print(balanceCouponResponseModel!.data!.bottleConceptionCount??00);
        globals.digitalCouponNumber=(balanceCouponResponseModel!.data!.digitalCoupons??0).toString();
        globals.manualCouponNumber=(balanceCouponResponseModel!.data!.manualCoupons??0).toString();
        globals.manualCouponNumber=(balanceCouponResponseModel!.data!.manualCoupons??0).toString();
        globals.bottleConceptionCount=(balanceCouponResponseModel!.data!.bottleConceptionCount??00).toString();
        globals.couponNumberList=(balanceCouponResponseModel!.data!.manualCouponLeaflets??[]);
        bottleConceptionCount.value=(balanceCouponResponseModel!.data!.bottleConceptionCount??00).toString();
      }else{
        couponBalance.value='No data Available';

      }
      }
    }catch (e) {
      log(e.toString());
      print('Error00004: $e');

      isLoading.value = false;
    }
  }
  Future<void>getMyOutStanding()async{
    try{
      isLoading.value=true;
      myOutStandingResponseModel= await APIManager.getOutStanding();
      if(myOutStandingResponseModel is MyOutStandingResponseModel){
        if(myOutStandingResponseModel?.data != null){
          outstandingCouponBalance.value= myOutStandingResponseModel!.data!.pendingCoupons.toString();
          outstandingCashBalance.value= myOutStandingResponseModel!.data!.pendingAmount.toString();
          print( myOutStandingResponseModel!.data!.pendingEmptyCan.toString());
          print( myOutStandingResponseModel!.data!.pendingAmount.toString());
          outstandingCanBalance.value= myOutStandingResponseModel!.data!.pendingEmptyCan.toString();
        }else{
          nextVisitDate.value='No data Available';

        }
      }
    }catch (e) {
      log(e.toString());
      print('Error00003: $e');

      isLoading.value = false;
    }
  }


 // created by new for api response

  // Future<void> listTheCart() async {
  //   try {
  //     listCartResponseModel = await APIManager.listTheCart();
  //     if (listCartResponseModel is ListCartResponseModel) {
  //       print(listCartResponseModel?.data);
  //
  //       // Clear existing cart list
  //       globals.cartList?.clear();
  //
  //       // Iterate through all carts and collect all items
  //       for (var cartData in listCartResponseModel?.data ?? []) {
  //         if (cartData.items != null) {
  //           globals.cartList?.addAll(cartData.items);
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //     print('Error List cart home: $e');
  //   }
  // }
  //created by abhijith

  Future<void> listTheCart() async {
    try {

      listCartResponseModel = await APIManager.listTheCart();
      if (listCartResponseModel
      is ListCartResponseModel) {
        print(listCartResponseModel?.data);if(listCartResponseModel?.data.items!=null) {
          globals.cartList?.clear();
          globals.cartList=listCartResponseModel?.data.items;
        }


      }
    } catch (e) {
      log(e.toString());
      print('Error List cart jome: $e');
    }
  }
}