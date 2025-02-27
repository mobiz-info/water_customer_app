import 'package:get/get.dart';
import 'package:water_customer_app/Models/parser_helper/parser_helper.dart';

class CouponListResponseModel {
  int? status;
  List<Coupon>? data;

  CouponListResponseModel({this.status, this.data});

  CouponListResponseModel.fromJson(Map<String, dynamic> json) {
    status = parseInt(json['status']);
    if (json['data'] != null) {
      data = <Coupon>[];
      json['data'].forEach((v) {
        data!.add(Coupon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coupon {
  String? id;
  String? productName;
  double? rate;
  int? leafCount;
  RxBool isProductInCart = false.obs;
  String? cartId;


  Coupon({
    this.id,
    this.productName,
    this.cartId,
    this.rate,
    this.leafCount,
    required this.isProductInCart,
  });

  Coupon.fromJson(Map<String, dynamic> json) {
    id = parseString(json['id']);
    productName = parseString(json['product_name']);
    rate = parseDouble(json['rate']);
    leafCount = parseInt(json['leaf_count']);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_name'] = productName;
    data['rate'] = rate;
    data['leaf_count'] = leafCount;
    return data;
  }
}