import 'package:water_customer_app/Models/parser_helper/parser_helper.dart';

class CoolerPurchaseResponseModel {
  int? status;
  List<Order>? orders;

  CoolerPurchaseResponseModel({this.status, this.orders});

  CoolerPurchaseResponseModel.fromJson(Map<String, dynamic> json) {
    status = parseInt(json['status']);
    if (json['data'] != null) {
      orders = [];
      json['data'].forEach((v) {
        orders!.add(Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (orders != null) {
      data['data'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  String? id;
  String? product;
  String? orderStatus;
  String? deliveryDate;

  Order({this.id, this.product, this.orderStatus, this.deliveryDate});

  Order.fromJson(Map<String, dynamic> json) {
    id = parseString(json['id']);
    product = parseString(json['product']);
    orderStatus = parseString(json['order_status']);
    deliveryDate = parseString(json['delivery_date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product'] = product;
    data['order_status'] = orderStatus;
    data['delivery_date'] = deliveryDate;
    return data;
  }
}