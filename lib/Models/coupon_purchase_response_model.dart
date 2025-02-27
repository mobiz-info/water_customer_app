import 'package:water_customer_app/Models/parser_helper/parser_helper.dart';

class CouponPurchaseResponseModel {
  CouponPurchaseResponseModel({
    required this.status,
    required this.couponList,
  });

  final int? status;
  final List<CouponPurchaseModelData> couponList;

  factory CouponPurchaseResponseModel.fromJson(Map<String, dynamic> json){
    return CouponPurchaseResponseModel(
      status: parseInt(json["status"]),
      couponList: json["data"] == null ? [] : List<CouponPurchaseModelData>.from(json["data"]!.map((x) => CouponPurchaseModelData.fromJson(x))),
    );
  }

}

class CouponPurchaseModelData {
  CouponPurchaseModelData({
    required this.id,
    required this.createdDate,
    required this.orderStatus,
  });

  final String? id;
  final String? createdDate;
  final String? orderStatus;

  factory CouponPurchaseModelData.fromJson(Map<String, dynamic> json){
    return CouponPurchaseModelData(
      id: parseString(json["id"]),
      createdDate: parseString(DateTime.tryParse(json["created_date"] ?? "")),
      orderStatus: parseString(json["order_status"]),
    );
  }

}
