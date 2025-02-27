import 'parser_helper/parser_helper.dart';

class MyOutStandingResponseModel {
  bool? status;
  String? message;
  OutstandingData? data;

  MyOutStandingResponseModel({this.status, this.message, this.data});

  MyOutStandingResponseModel.fromJson(Map<String, dynamic> json) {
    status = parseBool(json['status']);
    message = parseString(json['message']);
    data = json['data'] != null ? OutstandingData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class OutstandingData {
  int? pendingCoupons;
  int? pendingEmptyCan;
  double? pendingAmount;

  OutstandingData({this.pendingCoupons, this.pendingEmptyCan, this.pendingAmount});

  OutstandingData.fromJson(Map<String, dynamic> json) {
    pendingCoupons = parseInt(json['pending_coupons']);
    pendingEmptyCan = parseInt(json['pending_emptycan']);
    pendingAmount = parseDouble(json['pending_amount']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pending_coupons'] = pendingCoupons;
    data['pending_emptycan'] = pendingEmptyCan;
    data['pending_amount'] = pendingAmount;
    return data;
  }
}
