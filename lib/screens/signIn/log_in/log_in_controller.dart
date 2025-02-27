import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_customer_app/Models/emirate_location_model.dart';
import 'package:water_customer_app/Models/log_in_model.dart';
import 'package:water_customer_app/api/api_manager.dart';
import 'package:water_customer_app/screens/dashboard/bottom_navigaton/bottom_navigation_bar_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:water_customer_app/utils/Common.dart';
import 'package:water_customer_app/utils/globals.dart' as globals;

class LogInController extends GetxController {
  RxBool isLoading = false.obs;
  LogInResponseModel? logInResponseModel;
  final authData = AuthData();
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> isCredentialValid(String userName, String password) async {
    try {
      logInResponseModel = await APIManager.getLogin(userName, password);

      if (logInResponseModel?.status == false) {
        // Handle the "Invalid credentials" case
        Fluttertoast.showToast(
          msg: "Invalid credentials !!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else if (logInResponseModel?.status == true) {
        if (logInResponseModel?.message != 'Unauthenticated User!') {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          authData.setData(
              logInResponseModel!.data!.token ?? '0',
              logInResponseModel!.data!.userType ?? '0',
              logInResponseModel!.data!.salesType ?? '0',
              logInResponseModel!.data!.id ?? 0,
              logInResponseModel!.data!.username,
              password,
              logInResponseModel!.data!.customer_pk
          );


          prefs.setString('userId', logInResponseModel!.data!.id.toString());
          prefs.setString(
              'userToken', logInResponseModel!.data!.token.toString());
          prefs.setString(
              'userName', logInResponseModel!.data!.username.toString());
          prefs.setString(
              'salesType', logInResponseModel!.data!.salesType.toString());
          prefs.setString(
              'userType', logInResponseModel?.data?.userType.toString() ?? '0');
           prefs.setString(
              'userPk', logInResponseModel?.data?.customer_pk.toString() ?? '0');
          prefs.setString(
              'waterId', logInResponseModel?.data?.waterId.toString() ?? '0');
          prefs.setDouble(
              'waterRate', logInResponseModel?.data?.waterRate ?? 0);
          prefs.setString('passWord', password.toString());


          APIManager.postDeviceId(
              logInResponseModel?.data?.customer_pk??'0', globals.deviceId);


          globals.waterId=logInResponseModel!.data!.waterId.toString();
          globals.waterRate =logInResponseModel!.data!.waterRate!;
          Get.off(() => BottomNavigationBarScreen());
          Fluttertoast.showToast(
            msg: "Login Successfully",
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
      }
    } catch (e) {
      log(e.toString());
      print('Error00001: $e');

      isLoading.value = false;
    }
  }
}
