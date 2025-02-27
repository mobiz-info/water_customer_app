import 'parser_helper/parser_helper.dart';

class MyCustodyResponseModel {
  bool? status;
  String? message;
  List<Custody>? custody;

  MyCustodyResponseModel({this.status, this.message, this.custody});

  MyCustodyResponseModel.fromJson(Map<String, dynamic> json) {
    status = parseBool(json['status']);
    message = parseString(json['message']);
    if (json['custody'] != null) {
      custody = <Custody>[];
      json['custody'].forEach((v) {
        custody!.add(Custody.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (custody != null) {
      data['custody'] = custody!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Custody {
  String? productName;
  int? quantity;

  Custody({this.productName, this.quantity});

  Custody.fromJson(Map<String, dynamic> json) {
    productName = parseString(json['product_name']);
    quantity = parseInt(json['quantity']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_name'] = productName;
    data['quantity'] = quantity;
    return data;
  }
}