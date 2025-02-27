// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
//
// class SettingsController extends GetxController {
//   RxBool isDarkModeEnabled = false.obs;
//
//   void toggleTheme() {
//     isDarkModeEnabled.value = !isDarkModeEnabled.value;
//     Get.changeThemeMode(isDarkModeEnabled.value ? ThemeMode.dark : ThemeMode.light);
//   }
// }
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  RxBool isDarkModeEnabled = false.obs;
  RxBool isNotificationEnabled = false.obs;
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Load the saved theme preference
    isDarkModeEnabled.value = _storage.read('isDarkModeEnabled') ?? false;
    Get.changeThemeMode(isDarkModeEnabled.value ? ThemeMode.dark : ThemeMode.light);
  }
void themeStatus(){
  isDarkModeEnabled.value = _storage.read('isDarkModeEnabled') ?? false;
}void notificationStatusToggle(){
    isNotificationEnabled.value =  !isNotificationEnabled.value;
}
  void toggleTheme() {
    isDarkModeEnabled.value = !isDarkModeEnabled.value;
    Get.changeThemeMode(isDarkModeEnabled.value ? ThemeMode.dark : ThemeMode.light);
    // Save the preference
    _storage.write('isDarkModeEnabled', isDarkModeEnabled.value);
  }
}
