

import 'package:get/get.dart';

import 'parser_helper/parser_helper.dart';

class ProductListResponseModel {
  int? status;
  int? statusCode;
  List<Product>? data;

  ProductListResponseModel({this.status, this.statusCode, this.data});

  ProductListResponseModel.fromJson(Map<String, dynamic> json) {
    status = parseInt(json['status']);
    statusCode = parseInt(json['StatusCode']);
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['StatusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? id;
  String? productName;
  String? unit;
  String? tax;
  double? rate;
  DateTime? createdDate;
  RxBool isProductInCart = false.obs;

  Product({
    this.id,
    this.productName,
    this.unit,
    this.tax,
    this.rate,
    this.createdDate,
    required this.isProductInCart,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = parseString(json['id']);
    productName = parseString(json['product_name']);
    unit = parseString(json['unit']);
    tax = parseString(json['tax']);
    rate = parseDouble(json['rate']);
    createdDate = parseDateTime(json['created_date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_name'] = productName;
    data['unit'] = unit;
    data['tax'] = tax;
    data['rate'] = rate;
    data['created_date'] = createdDate?.toIso8601String();
    return data;
  }
}
