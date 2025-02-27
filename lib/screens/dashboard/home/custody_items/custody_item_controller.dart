import 'dart:developer';

import 'package:get/get.dart';
import 'package:water_customer_app/Models/my_custody_response_mdel.dart';
import 'package:water_customer_app/api/api_manager.dart';

class CustodyItemController extends GetxController{
 RxBool isLoading=false.obs;
 MyCustodyResponseModel? myCustodyResponseModel;

  Future<void>getMyCustody()async{
    try{
      isLoading.value=true;
      myCustodyResponseModel= await APIManager.getMyCustody();
      if(myCustodyResponseModel is MyCustodyResponseModel){
        if(myCustodyResponseModel?.custody != null){
          print(myCustodyResponseModel?.custody?[0].productName);

        }else{


        }
      }
    }catch (e) {
      log(e.toString());
      print('Error00007: $e');

    }
    isLoading.value = false;
  }
}