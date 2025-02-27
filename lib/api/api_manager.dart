import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/Models/add_to_cart_response_model.dart';
import 'package:water_customer_app/Models/balance_coupon_response_model.dart';
import 'package:water_customer_app/Models/cooler_purchase_response_model.dart';
import 'package:water_customer_app/Models/coupon_list_response_model.dart';
import 'package:water_customer_app/Models/coupon_purchase_response_model.dart';
import 'package:water_customer_app/Models/emirate_location_model.dart';
import 'package:water_customer_app/Models/list_cart_response_model.dart';
import 'package:water_customer_app/Models/log_in_model.dart';
import 'package:water_customer_app/Models/my_custody_response_mdel.dart';
import 'package:water_customer_app/Models/my_outstanding_response_mdel.dart';
import 'package:water_customer_app/Models/next_visit_date_response_model.dart';
import 'package:water_customer_app/Models/okay_model.dart';
import 'package:water_customer_app/Models/order_placng_response_model.dart';
import 'package:water_customer_app/Models/order_water_response_model.dart';
import 'package:water_customer_app/utils/Common.dart';
import '../Models/product_List_response_model.dart';
import 'api_network_helper.dart';

class APIManager {
  static String userLoginUrl = "$baseUrl/api/customer-login/";
  static String NextVisitDateUrl = "$baseUrl/api/customer-next-visit-date/";
  static String couponBalanceUrl = "$baseUrl/api/customer-coupon-balance/";
  static String outStandingBalanceUrl =
      "$baseUrl/api/customer-outstanding-balance/";
  static String myCustodyUrl =
      "$baseUrl/api/custody_customer_view";
  static String orderWaterUrl = "$baseUrl/api/customer-orders/";
  static String postComplaintUrl = "$baseUrl/api/complaints_create/";
  static String productListUrl = "$baseUrl/api/product-items/?non_coupon=false";
  static String couponListUrl = "$baseUrl/api/coupons-products/";
  static String coolerPurchaseListUrl = "$baseUrl/api/dispensers-coolers-purchases/";
  static String couponPurchaseListUrl = "$baseUrl/api/customer-coupon-purchase/";
  static String waterBottlePurchaseListUrl = "$baseUrl/api/water_bottle_purchases/";
  static String postDeviceIdUrl = "$baseUrl/api/send_customer_device_token/";
  static String addToCartUrl = "$baseUrl/api/customer-cart/";
  static String listTheCartUrl = "$baseUrl/api/customer-cart/";
  static String deleteTheCartUrl = "$baseUrl/api/customer-cart/";
  static String placeOrderUrl = "$baseUrl/api/customer-orders/";
  static String deleteAccountUrl = "$baseUrl/api/customers-delete-request/";
  static String pauseMyDeliveryUrl = "$baseUrl/api/vacations/add/";
  static String editOrderUrl = "$baseUrl/appostCustomerRegistrationi/customer-cart/";
  static String getEmirateLocationUrl = "$baseUrl/api/emirates-based-locations/";
  static String postCustomerRegistrationUrl = "$baseUrl/api/customer-registration-request/";


  static Future<dynamic> postDeviceId(String userId, String deviceId) async {
    final url = postDeviceIdUrl;
    final body = {"device_token": deviceId, "customer_id": userId};
    try {
      final response = await NetworkHelper().postWithBody(url: url, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Successfully passed device token");
      } else {
        print('Failed to pass device token'); // Return an error message
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error: $e');
      return (e);
    }
  }



  static Future<dynamic> getLogin(String userId, String password) async {
    String url = userLoginUrl;
    final body = {"mobile_number": userId, "password": password};

    try {
      final response = await NetworkHelper().postWithBody(url: url, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        LogInResponseModel logInResponseModel =
            LogInResponseModel.fromJson(response.data);

        return logInResponseModel; // Return an error message
      } else {
        final errorMessage = response.data;
        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 01: $e');
      return (e);
    }
  }

  static Future<dynamic> getNextVisitDate() async {
    final url = NextVisitDateUrl;
    try {
      final response = await NetworkHelper().getWithAuth(
          url: url,
          username: AuthData().username ?? '0',
          password: AuthData().password ?? '0');

      if (response.statusCode == 200 || response.statusCode == 201) {
        NextVisitDateResponseModel nextVisitDateResponseModel =
            NextVisitDateResponseModel.fromJson(response.data);

        return nextVisitDateResponseModel; // Return an error message
      } else {
        final errorMessage = response.data;
        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 02: $e');
      return (e);
    }
  }

  static Future<dynamic> getOutStanding() async {
    final url = outStandingBalanceUrl;
    try {
      final response = await NetworkHelper().getWithAuth(
          url: url,
          username: AuthData().username ?? '0',
          password: AuthData().password ?? '0');

      if (response.statusCode == 200 || response.statusCode == 201) {
        MyOutStandingResponseModel myOutStandingResponseModel =
            MyOutStandingResponseModel.fromJson(response.data);

        return myOutStandingResponseModel; // Return an error message
      } else {
        final errorMessage = response.data;
        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 03: $e');
      return (e);
    }
  }

  static Future<dynamic> orderWaterPost(
      String productId,
      String deliveryDate,
      int quantity,
      double totalAmount,
      int noEmptyBottleReturn,
      bool emptyBottleRequired,
      int noEmptyBottleRequired,
      double emptyBottleAmount,
      double totalNetAmount,
      String paymentOption) async {
    final url = orderWaterUrl;
    final body = {
      "product": productId,
      "delivery_date": deliveryDate,
      "quantity": quantity,
      "total_amount": totalAmount,
      "no_empty_bottle_return": noEmptyBottleReturn,
      "empty_bottle_required": emptyBottleRequired,
      "no_empty_bottle_required": noEmptyBottleRequired,
      "empty_bottle_amount": emptyBottleAmount,
      "total_net_amount": totalNetAmount,
      "payment_option": paymentOption
    };

    try {
      final response = await NetworkHelper().postWithBodyAuth(
          url: url,
          body: body,
          username: AuthData().username,
          password: AuthData().password);

      if (response.statusCode == 200 || response.statusCode == 201) {
        OrderWaterResponseModel orderWaterResponseModel =
        OrderWaterResponseModel.fromJson(response.data);

        return orderWaterResponseModel; // Return an error message
      } else {
        final errorMessage = response;
        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 04: $e');
      return (e);
    }
  }

  static Future<dynamic> postComplaint(
      String complaintBody) async {
    final url = postComplaintUrl;
    final body = {
      "created_by":56,
      "customer": AuthData().user_pk,
      "complaint": complaintBody,
      "status": "Pending",
      "category":"Product",
      "subcategory":"5 Gallon"
    };

    try {
      final response = await NetworkHelper().postWithBodyAuth(
          url: url,
          body: body,
          username: AuthData().username,
          password: AuthData().password);

      if (response.statusCode == 200 || response.statusCode == 201) {
        OrderWaterResponseModel orderWaterResponseModel =
            OrderWaterResponseModel.fromJson(response.data);

        return 'Done.'; // Return an error message
      } else {
        final errorMessage = response;
        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 04: $e');
      return (e);
    }
  }

  static Future<dynamic> getProductList() async {
    final url = "$productListUrl";
    try {
      final response = await NetworkHelper().getWithAuth(
          url: url,
          username: AuthData().username ?? '0',
          password: AuthData().password ?? '0');

      if (response.statusCode == 200 || response.statusCode == 201) {
        ProductListResponseModel productListResponseModel =
            ProductListResponseModel.fromJson(response.data);

        return productListResponseModel;
      } else {
        final errorMessage = response.data;

        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 05: $e');
      return (e);
    }
  }

  static Future<dynamic> getCouponList() async {
    final url = "$couponListUrl";
    try {
      final response = await NetworkHelper().getWithAuth(
          url: url,
          username: AuthData().username ?? '0',
          password: AuthData().password ?? '0');

      if (response.statusCode == 200 || response.statusCode == 201) {
        CouponListResponseModel couponListResponseModel =
            CouponListResponseModel.fromJson(
                {"status": 200, "data": response.data});

        return couponListResponseModel;
      } else {
        final errorMessage = response.data;

        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 06: $e');
      return (e);
    }
  }
  static Future<dynamic> getCoolerPurchase() async {
    final url = "$coolerPurchaseListUrl";
    try {
      final response = await NetworkHelper().getWithAuth(
          url: url,
          username: AuthData().username ?? '0',
          password: AuthData().password ?? '0');

      if (response.statusCode == 200 || response.statusCode == 201) {
        CoolerPurchaseResponseModel coolerPurchaseResponseModel =
        CoolerPurchaseResponseModel.fromJson(
                {"status": 200, "data": response.data});

        return coolerPurchaseResponseModel;
      } else {
        final errorMessage = response.data;

        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 07: $e');
      return (e);
    }
  }
  static Future<dynamic> getCouponPurchase() async {
    final url = "$couponPurchaseListUrl";
    try {
      final response = await NetworkHelper().getWithAuth(
          url: url,
          username: AuthData().username ?? '0',
          password: AuthData().password ?? '0');

      if (response.statusCode == 200 || response.statusCode == 201) {
        CouponPurchaseResponseModel couponPurchaseResponseModel =
        CouponPurchaseResponseModel.fromJson(
            {"status": 200, "data": response.data});

        return couponPurchaseResponseModel;
      } else {
        final errorMessage = response.data;

        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 07: $e');
      return (e);
    }
  }
  static Future<dynamic> getWaterBottlePurchase() async {
    final url = "$waterBottlePurchaseListUrl";
    try {
      final response = await NetworkHelper().getWithAuth(
          url: url,
          username: AuthData().username ?? '0',
          password: AuthData().password ?? '0');

      if (response.statusCode == 200 || response.statusCode == 201) {
        CoolerPurchaseResponseModel coolerPurchaseResponseModel =
        CoolerPurchaseResponseModel.fromJson(
            {"status": 200, "data": response.data});

        return coolerPurchaseResponseModel;
      } else {
        final errorMessage = response.data;

        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 07: $e');
      return (e);
    }
  }

  static Future<dynamic> getMyCustody() async {
    final url = myCustodyUrl;
    try {
      final response = await NetworkHelper().getWithAuth(
          url: url,
          username: AuthData().username ?? '0',
          password: AuthData().password ?? '0');

      if (response.statusCode == 200 || response.statusCode == 201) {
        MyCustodyResponseModel myCustodyResponseModel =
        MyCustodyResponseModel.fromJson(

        {"status":true,"message":"success!","custody":response.data});

        return myCustodyResponseModel; // Return an error message
      } else {
        final errorMessage = response.data;
        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 08: $e');
      return (e);
    }
  }
  static Future<dynamic> getCouponBalance() async {
    final url = couponBalanceUrl;
    try {
      final response = await NetworkHelper().getWithAuth(
          url: url,
          username: AuthData().username ?? '0',
          password: AuthData().password ?? '0');

      if (response.statusCode == 200 || response.statusCode == 201) {
        BalanceCouponResponseModel balanceCouponResponseModel =
        BalanceCouponResponseModel.fromJson(response.data);
print ('1111111111111111111111111111');
print (balanceCouponResponseModel);
        return balanceCouponResponseModel; // Return an error message
      } else {
        final errorMessage = response.data;
        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 09: $e');
      return (e);
    }
  }
  static Future<dynamic> addToCart(String date,String productId,int quantity,double price,) async {
    final url = addToCartUrl;
    final body = {
      "delivery_date": date,
      "items":
      {
        "product": productId,
        "quantity": quantity,
        "price": price
      }

    };

    try {
      final response = await NetworkHelper().postWithBodyAuth(
          url: url,
          body: body,
          username: AuthData().username,
          password: AuthData().password);

      if (response.statusCode == 200 || response.statusCode == 201) {
        AddToCartResponseModel addToCartResponseModel =
        AddToCartResponseModel.fromJson(response.data);

        return 'Done.'; // Return an error message
      } else {
        final errorMessage = response.data;
        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 10: $e');
      return (e);
    }
  }static Future<dynamic> listTheCart() async {
    final url = listTheCartUrl;

    try {
      final response = await NetworkHelper().getWithAuth(
          url: url,
          username: AuthData().username ??'0',
          password: AuthData().password ??'0');

      if (response.statusCode == 200 || response.statusCode == 201) {
        ListCartResponseModel listCartResponseModel =
        ListCartResponseModel.fromJson(response.data);

        return listCartResponseModel; // Return an error message
      } else {
        final errorMessage = response.data;
        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 11: $e');
      return (e);
    }
  }
  static Future<dynamic> deleteTheCart( String productId) async {

    final url = deleteTheCartUrl;
    final body =
      {
        "item_pk": productId
      };
    print('$body');

    try {
      final response = await NetworkHelper().deleteWithAuth(
          url: url,
          body: body,
          username: AuthData().username ??'0',
          password: AuthData().password ??'0');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'Done.'; // Return an error message
      } else {
        final errorMessage = response.data;
        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 12: $e');
      return (e);
    }
  }
  static Future<dynamic> placeOrder(String catId) async {
    final url = placeOrderUrl;
    final body = {
      "cart_id":catId,
    };

    try {
      final response = await NetworkHelper().postWithBodyAuth(
          url: url,
          body: body,
          username: AuthData().username,
          password: AuthData().password);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // OrderPlacingResponseModel orderPlacingResponseModel=
        //     OrderPlacingResponseModel.fromJson(response);
        OrderPlacingResponseModel orderPlacingResponseModel =
        OrderPlacingResponseModel.fromJson(response.data);
        return 'Done.'; // Return an error message
      } else {
        final errorMessage = response.data;
        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 13: $e');
      return (e);
    }
  }

  static Future<dynamic> postDeleteAccount() async {
    final url = deleteAccountUrl;
    final body = {
      "customer": AuthData().user_pk,
      "reason": "Account Deletion"
    }
    ;

    try {
      final response = await NetworkHelper().postWithBodyAuth(
          url: url,
          body: body,
          username: AuthData().username,
          password: AuthData().password);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: "Account deletion submitted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        return 'Done.'; // Return an error message
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        final errorMessage = response.data;
        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 13: $e');
      return (e);
    }
  }

  static Future<dynamic> PauseMyDelivery(
      String startDate, String edDate, String note) async {
    final url = pauseMyDeliveryUrl;
    final body = {
      "customer": AuthData().user_pk,
      "start_date":startDate ,
      "end_date":edDate,
      "note": note
    };

    try {
      final response = await NetworkHelper().postWithBodyAuth(
          url: url,
          body: body,
          username: AuthData().username,
          password: AuthData().password);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // OrderWaterResponseModel orderWaterResponseModel =
        // OrderWaterResponseModel.fromJson(response.data);

        return 'Done.'; // Return an error message
      } else {
        final errorMessage = response;
        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 14: $e');
      return (e);
    }
  }static Future<dynamic> editOrder(
      String productCartId, int quantity) async {
    final url = editOrderUrl;
    final body = {
      "item_pk": productCartId,
      "item_qty": quantity
    };

    try {
      final response = await NetworkHelper().putWithAuth(
          url: url,
          body: body,
          username: AuthData().username,
          password: AuthData().password);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ListCartResponseModel listCartResponseModel =
        ListCartResponseModel.fromJson(response.data);

        return listCartResponseModel; // Return an error message
      } else {
        final errorMessage = response;
        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 15: $e');
      return (e);
    }
  }
  static Future<dynamic> getEmirateLocation(String username,String password) async {
    final url = getEmirateLocationUrl;


    try {
      final response = await NetworkHelper().getWithAuth(url: url, username: username, password: password);

      if (response.statusCode == 200 || response.statusCode == 201) {


        EmirateLocationModel emirateLocationModel =
        EmirateLocationModel.fromJson(response.data);

        if (emirateLocationModel != null) {
          return emirateLocationModel;
        }
      } else {
        final errorMessage = response.data;

        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 16: $e');
      return (e);
    }
  }
  static Future<dynamic> postCustomerRegistration(

      String name,
      String phoneNumber,
      String buildingNumber,
      String roomNumber,
      String location,
      String emirate,
      List<String> days,
      int bottleCount,


      ) async {
    final url = postCustomerRegistrationUrl;
    final body = {
      "name": name,
      "phone_no": phoneNumber,
      "building_name": buildingNumber,
      "room_or_flat_no": roomNumber,
      "location": location,
      "emirate": emirate,
      "visit_schedule": {"days": days},
      "no_of_5g_bottles_required": bottleCount
    };
    try {
      final response = await NetworkHelper().postWithBody(url: url, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Successfully registration requested");
        return 'Done';
      } else {
        print('Failed to registration request'); // Return an error message
        return 'fail';
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error 17: $e');
      return (e);
    }
  }
  }
