
import 'package:water_customer_app/Models/parser_helper/parser_helper.dart';

class OrderWaterResponseModel {
  String? id;
  String? product;
  double? quantity;
  double? totalAmount;
  int? noEmptyBottleReturn;
  bool? emptyBottleRequired;
  int? noEmptyBottleRequired;
  double? emptyBottleAmount;
  double? totalNetAmount;
  DateTime? deliveryDate;
  String? paymentOption;
  String? orderStatus;

  OrderWaterResponseModel({
    this.id,
    this.product,
    this.quantity,
    this.totalAmount,
    this.noEmptyBottleReturn,
    this.emptyBottleRequired,
    this.noEmptyBottleRequired,
    this.emptyBottleAmount,
    this.totalNetAmount,
    this.deliveryDate,
    this.paymentOption,
    this.orderStatus,
  });

  OrderWaterResponseModel.fromJson(Map<String, dynamic> json) {
    id = parseString(json['id']);
    product = parseString(json['product']);
    quantity = parseDouble(json['quantity']);
    totalAmount = parseDouble(json['total_amount']);
    noEmptyBottleReturn = parseInt(json['no_empty_bottle_return']);
    emptyBottleRequired = parseBool(json['empty_bottle_required']);
    noEmptyBottleRequired = parseInt(json['no_empty_bottle_required']);
    emptyBottleAmount = parseDouble(json['empty_bottle_amount']);
    totalNetAmount = parseDouble(json['total_net_amount']);
    deliveryDate = parseDateTime(json['delivery_date']);
    paymentOption = parseString(json['payment_option']);
    orderStatus = parseString(json['order_status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product'] = product;
    data['quantity'] = quantity;
    data['total_amount'] = totalAmount;
    data['no_empty_bottle_return'] = noEmptyBottleReturn;
    data['empty_bottle_required'] = emptyBottleRequired;
    data['no_empty_bottle_required'] = noEmptyBottleRequired;
    data['empty_bottle_amount'] = emptyBottleAmount;
    data['total_net_amount'] = totalNetAmount;
    data['delivery_date'] = deliveryDate?.toIso8601String();
    data['payment_option'] = paymentOption;
    data['order_status'] = orderStatus;
    return data;
  }
}
