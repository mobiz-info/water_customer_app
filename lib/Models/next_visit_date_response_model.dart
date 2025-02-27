

import 'package:water_customer_app/Models/parser_helper/parser_helper.dart';

class NextVisitDateResponseModel {
  bool? status;
  String? message;
  String? data;

  NextVisitDateResponseModel({this.status, this.message, this.data});

  NextVisitDateResponseModel.fromJson(Map<String, dynamic> json) {
    status = parseBool(json['status']);
    message = parseString(json['message']);
    data = parseString(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}