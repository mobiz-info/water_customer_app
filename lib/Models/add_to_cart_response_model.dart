

import 'package:water_customer_app/Models/parser_helper/parser_helper.dart';

class AddToCartResponseModel {
  final int? statusCode;
  final Data data;
  final String? message;

  AddToCartResponseModel({
    required this.statusCode,
    required this.data,
    required this.message,
  });

  factory AddToCartResponseModel.fromJson(Map<String, dynamic> json) {
    return AddToCartResponseModel(
      statusCode: parseInt(json['statusCode']),
      data: Data.fromJson(json['data']),
      message: parseString(json['message']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'data': data.toJson(),
      'message': message,
    };
  }
}

class Data {
  final String? deliveryDate;
  final Items items;

  Data({
    required this.deliveryDate,
    required this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      deliveryDate: parseString(json['delivery_date']),
      items: Items.fromJson(json['items']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'delivery_date': deliveryDate,
      'items': items.toJson(),
    };
  }
}

class Items {
  final String? product;
  final String? quantity;
  final String? price;

  Items({
    required this.product,
    required this.quantity,
    required this.price,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      product: parseString(json['product']),
      quantity: parseString(json['quantity']),
      price: parseString(json['price']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'quantity': quantity,
      'price': price,
    };
  }
}
