import 'package:water_customer_app/Models/balance_coupon_response_model.dart';
import 'package:water_customer_app/Models/list_cart_response_model.dart';
import 'package:water_customer_app/Models/notification_model.dart';
import 'package:get/get.dart';

import '../Models/emirate_location_model.dart';

String waterId = '';
double waterRate = 00.0;
String date = '';
String deviceId = '';
String appName = "";
String packageName = "";
String version = "";
String buildNumber = "";
String digitalCouponNumber = "";
String manualCouponNumber = "";
String bottleConceptionCount = "";
String? nextDeliveryDate = '';
List<CartItem>? cartList = [];
List<EmirateLocationData>? emirate=[];
List<ManualCouponLeaflet>? couponNumberList = [];


RxList<Data> expenseAddList = RxList<Data>([]);



