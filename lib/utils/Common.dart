import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_customer_app/Models/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_customer_app/utils/globals.dart' as globals;

//"http://68.183.94.11:881";  http://68.183.94.11:91";
final Map<String, Map<String, dynamic>> appDetails = {

  "Sana Water": {
    "logo": "sanaWaterLogo.png",
    "url": "http://68.183.94.11:881",
    "name": "Sana",
    "theme":const LinearGradient(
      colors: [
        Color(0xFF003D99), // Top color
        Color(0xFF55CAE5), // Bottom color
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    "mailId":"sanapurewater@yahoo.com",
    "website":"sanawater.com",
    "phoneNo":"+971507474835",
    "primaryColor":Color(0xFF003D99),
    "secondaryColor":Color(0xFF224985),
    "accentColor":Color(0xFF5D9EFF),

  },
};

String baseUrl = appDetails[globals.appName]?['url'] ?? "";
final String imageName = appDetails[globals.appName]?['logo'] ?? "";
final String logoPath = 'Assets/Images/${imageName}';
final String appName = appDetails[globals.appName]?['name'] ?? "";
final String webSiteUrl = appDetails[globals.appName]?['website'] ?? "";
final String phoneNo = appDetails[globals.appName]?['phoneNo'] ?? "";
final String mailId = appDetails[globals.appName]?['mailId'] ?? "";
final Color primary = appDetails[globals.appName]?['primaryColor'] ?? "";
final Color secondary = appDetails[globals.appName]?['secondaryColor'] ?? "";
final Color accent = appDetails[globals.appName]?['accentColor'] ?? "";
final LinearGradient themeGradient = appDetails[globals.appName]?['theme'] ?? LinearGradient(
  colors: [
    Color(0xFF2FB8D8), // Top color
    Color(0xFF55CAE5), // Bottom color
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);


final String versionNo = "${globals.version}+${globals.buildNumber}";

class AuthData {
  static final AuthData _instance = AuthData._internal();

  factory AuthData() {
    return _instance;
  }

  static const String keyCustomerList = 'customer_list';
  static const String keyEmirateList = 'emirate_list';
  static const String keyLocationList = 'location_list';
  static const String keyRouteList = 'route_list';

  AuthData._internal();

  String? user_token;
  String? user_type;
  String? sales_type;
  String? response;
  String? username;
  int? user_id;
  int callCount = 0;
  String? password;
  String? user_pk;

  String pck_cat_id = "";
  String pck_sub_cat_id = "";
  String pck_ord_id = "";
  String pck_ord_cstmr_id = "";

  String? customerListDownloadTime;
  String? allListDownloadTime;

  void setData(String token, String userType, String salesType, int userId, user_name, passWord, userPk) {
    user_token = token;
    user_type = userType;
    sales_type = salesType;
    user_id = userId;
    username = user_name;
    password = passWord;
  user_pk = userPk;
  }

  void setCatId(cat_id) {
    pck_cat_id = cat_id ?? "";
  }

  void setOrdCstmrId(ord_id, cstm_id) {
    pck_ord_id = ord_id ?? "";
    pck_ord_cstmr_id = cstm_id ?? "";
  }

  void setSubCatId(sub_cat_id) {
    pck_sub_cat_id = sub_cat_id ?? "";
  }

  void clearData() {
    user_token = null;
    user_type = null;
    user_id = null;
    username = null;
  }

  void setResponse(value) {
    response = value;
  }

  void clearResponse() {
    response = null;
  }

  void resetCount() {
    if (callCount != 0) {
      callCount = 0;
    }
  }

// Function to clear user token from SharedPreferences
  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userToken');
  }
}
