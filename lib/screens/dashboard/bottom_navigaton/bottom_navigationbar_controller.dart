import 'dart:developer';

import 'package:get/get.dart';
import 'package:water_customer_app/Models/emirate_location_model.dart';
import 'package:water_customer_app/api/api_manager.dart';
import 'package:water_customer_app/utils/globals.dart' as globals;

class BottomNavigationBarController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

}
