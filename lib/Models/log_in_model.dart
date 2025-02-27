import 'parser_helper/parser_helper.dart';

class LogInResponseModel {
  bool? status;
  LogInData? data;
  String? message;

  LogInResponseModel({this.status, this.data, this.message});

  LogInResponseModel.fromJson(Map<String, dynamic> json) {
    status = parseBool(json['status']);
    data = json['data'] != null ? LogInData.fromJson(json['data']) : null;
    message = parseString(json['message']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class LogInData {
  int? id;
  String? customer_pk;
  String? username;
  String? userType;
  String? salesType;
  double? waterRate;
  String? waterId;
  String? token;

  LogInData({
    this.id,
    this.customer_pk,
    this.username,
    this.userType,
    this.salesType,
    this.waterRate,
    this.waterId,
    this.token
  });

  LogInData.fromJson(Map<String, dynamic> json) {
    id = parseInt(json['id']);
    customer_pk = parseString(json['customer_pk']);
    username = parseString(json['username']);
    userType = parseString(json['user_type']);
    salesType = parseString(json['sales_type']);
    waterRate = parseDouble(json['water_rate']);
    waterId = parseString(json['water_id']);
    token = parseString(json['token']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['user_type'] = userType;
    data['sales_type'] = salesType;
    data['water_rate'] = waterRate;
    data['water_id'] = waterId;
    data['token'] = token;
    return data;
  }
}
