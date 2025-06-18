import 'package:water_customer_app/Models/parser_helper/parser_helper.dart';



//created by new

class CouponPurchaseResponseModel {
  final int? status;
  final List<CouponPurchaseModelData> couponList;
  final String? message;

  CouponPurchaseResponseModel({
    required this.status,
    required this.couponList,
    this.message,
  });

  factory CouponPurchaseResponseModel.fromJson(Map<String, dynamic> json) {
    return CouponPurchaseResponseModel(
      status: parseInt(json["status"]),
      couponList: json["data"] == null || json["data"] is String
          ? []
          : List<CouponPurchaseModelData>.from(
          json["data"]!.map((x) => CouponPurchaseModelData.fromJson(x))),
        message: json["detail"]
    );
  }
}

//created by abhijith


// class CouponPurchaseResponseModel {
//   CouponPurchaseResponseModel({
//     required this.status,
//     required this.couponList,
//   });
//
//   final int? status;
//   final List<CouponPurchaseModelData> couponList;
//
//   factory CouponPurchaseResponseModel.fromJson(Map<String, dynamic> json){
//     return CouponPurchaseResponseModel(
//       status: parseInt(json["status"]),
//       couponList: json["data"] == null ? [] : List<CouponPurchaseModelData>.from(json["data"]!.map((x) => CouponPurchaseModelData.fromJson(x))),
//     );
//   }
//
// }
//created by nwe
class CouponPurchaseModelData {

  final String? id;
  final String? createdDate;
  final String? orderStatus;
  int? totalQuantity;
  CouponPurchaseModelData({
    required this.id,
    required this.createdDate,
    required this.orderStatus,
    this.totalQuantity
  });


  factory CouponPurchaseModelData.fromJson(Map<String, dynamic> json){
    return CouponPurchaseModelData(
      id: parseString(json["order_no"]),
      createdDate: parseString(json['order_date']),

      orderStatus: parseString(json["order_status"]),
      totalQuantity: parseInt(json['total_quantity']),
    );
  }

}
//created by abhijith

// class CouponPurchaseModelData {
//   CouponPurchaseModelData({
//     required this.id,
//     required this.createdDate,
//     required this.orderStatus,
//   });
//
//   final String? id;
//   final String? createdDate;
//   final String? orderStatus;
//
//   factory CouponPurchaseModelData.fromJson(Map<String, dynamic> json){
//     return CouponPurchaseModelData(
//       id: parseString(json["id"]),
//       createdDate: parseString(DateTime.tryParse(json["created_date"] ?? "")),
//       orderStatus: parseString(json["order_status"]),
//     );
//   }
//
// }
