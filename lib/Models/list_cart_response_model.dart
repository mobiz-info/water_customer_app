

import 'package:water_customer_app/Models/parser_helper/parser_helper.dart';

class ListCartResponseModel {
  final int? statusCode;
  final CartData data;

  ListCartResponseModel({
    required this.statusCode,
    required this.data,
  });

  factory ListCartResponseModel.fromJson(Map<String, dynamic> json) {
    return ListCartResponseModel(
      statusCode: parseInt(json['statusCode']),
      data: CartData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'data': data.toJson(),
    };
  }
}

class CartData {
  final String? id;
  final String? customer;
  final String? grandTotal;
  final String? deliveryDate;
  final bool? orderStatus;
  final List<CartItem> items;

  CartData({
    required this.id,
    required this.customer,
    required this.grandTotal,
    required this.deliveryDate,
    required this.orderStatus,
    required this.items,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: parseString(json['id']),
      customer: parseString(json['customer']),
      grandTotal: parseString(json['grand_total']),
      deliveryDate: parseString(json['delivery_date']),
      orderStatus: parseBool(json['order_status']),
      items: List<CartItem>.from(
        json['items'].map((item) => CartItem.fromJson(item)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer': customer,
      'grand_total': grandTotal,
      'delivery_date': deliveryDate,
      'order_status': orderStatus,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class CartItem {
  final String? id;
  final String? product;
  final String? quantity;
  final String? price;
  final String? totalAmount;
  final String? productId;

  CartItem({
    required this.id,
    this.product,
    required this.quantity,
    required this.price,
    required this.totalAmount,
    required this.productId,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: parseString(json['id']),
      product: parseString(json['product_name']),
      quantity: parseString(json['quantity']),
      price: parseString(json['price']),
      totalAmount: parseString(json['total_amount']),
      productId: parseString(json['product_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product,
      'quantity': quantity,
      'price': price,
      'total_amount': totalAmount,
      'product_id': productId,
    };
  }
}
