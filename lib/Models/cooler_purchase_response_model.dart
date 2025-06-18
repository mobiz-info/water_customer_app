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
//created by abhijith
// class Order {
//   String? id;
//   String? product;
//   String? orderStatus;
//   String? deliveryDate;
//
//   Order({this.id, this.product, this.orderStatus, this.deliveryDate});
//
//   Order.fromJson(Map<String, dynamic> json) {
//     id = parseString(json['id']);
//     product = parseString(json['product']);
//     orderStatus = parseString(json['order_status']);
//     deliveryDate = parseString(json['delivery_date']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['product'] = product;
//     data['order_status'] = orderStatus;
//     data['delivery_date'] = deliveryDate;
//     return data;
//   }
// }
class Order {
  String? id;
  String? product;
  String? orderStatus;
  String? deliveryDate;
  int? totalQuantity;

  Order({this.id, this.product, this.orderStatus, this.deliveryDate ,
    this.totalQuantity
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = parseString(json['order_no']);
    product = parseString(json['product']);
    orderStatus = parseString(json['order_status']);
    deliveryDate = parseString(json['order_date']);
    totalQuantity = parseInt(json['total_quantity']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_no'] = id;
    data['product'] = product;
    data['order_status'] = orderStatus;
    data['order_date'] = deliveryDate;
    data['total_quantity'] = totalQuantity;
    return data;
  }
}

//created by new for new requirement for customer
// class Order {
//   String? id;
//   String? product;
//   String? orderStatus;
//   String? deliveryDate;
//   List<OrderItem>? items;
//
//   Order({
//     this.id,
//     this.product,
//     this.orderStatus,
//     this.deliveryDate,
//     this.items
//   });
//
//   Order.fromJson(Map<String, dynamic> json) {
//     id = parseString(json['id']);
//     product = parseString(json['product']);
//     orderStatus = parseString(json['order_status']);
//     deliveryDate = parseString(json['delivery_date']);
//     if (json['items'] != null) {
//       items = [];
//       json['items'].forEach((v) {
//         items!.add(OrderItem.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['product'] = product;
//     data['order_status'] = orderStatus;
//     data['delivery_date'] = deliveryDate;
//     if (items != null) {
//       data['items'] = items!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class OrderItem {
//   String? productName;
//   String? quantity;
//   String? price;
//   String? totalAmount;
//
//   OrderItem({
//     this.productName,
//     this.quantity,
//     this.price,
//     this.totalAmount
//   });
//
//   OrderItem.fromJson(Map<String, dynamic> json) {
//     productName = parseString(json['product_name']);
//     quantity = parseString(json['quantity']);
//     price = parseString(json['price']);
//     totalAmount = parseString(json['total_amount']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['product_name'] = productName;
//     data['quantity'] = quantity;
//     data['price'] = price;
//     data['total_amount'] = totalAmount;
//     return data;
//   }
// }