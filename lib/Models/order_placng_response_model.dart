

import 'package:water_customer_app/Models/parser_helper/parser_helper.dart';

class OrderPlacingResponseModel {
  final int? statusCode;
  final String? title;
  final String? message;

  OrderPlacingResponseModel({
     this.statusCode,
     this.title,
     this.message,
  });

  factory OrderPlacingResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderPlacingResponseModel(
      statusCode: parseInt(json['statusCode']),
      title: parseString(json['title']),
      message: parseString(json['message']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'title': title,
      'message': message,
    };
  }
}
