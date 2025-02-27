import 'package:water_customer_app/Models/parser_helper/parser_helper.dart';

class BalanceCouponResponseModel {
  final bool? status;
  final String? message;
  final BalanceCouponData? data;

  BalanceCouponResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory BalanceCouponResponseModel.fromJson(Map<String, dynamic> json) {
    return BalanceCouponResponseModel(
      status: parseBool(json['status']),
      message: parseString(json['message']),
      data: json['data'] != null
          ? BalanceCouponData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class BalanceCouponData {
  final int? pendingCoupons;
  final int? digitalCoupons;
  final int? manualCoupons;
  final List<ManualCouponLeaflet>? manualCouponLeaflets;
  final int? bottleConceptionCount;

  BalanceCouponData({
    this.pendingCoupons,
    this.digitalCoupons,
    this.manualCoupons,
    this.manualCouponLeaflets,
    this.bottleConceptionCount,
  });

  factory BalanceCouponData.fromJson(Map<String, dynamic> json) {
    return BalanceCouponData(
      pendingCoupons: parseInt(json['pending_coupons']),
      digitalCoupons: parseInt(json['digital_coupons']),
      manualCoupons: parseInt(json['manual_coupons']),
      manualCouponLeaflets: json['manual_coupon_leaflets'] != null
          ? (json['manual_coupon_leaflets'] as List)
          .map((item) => ManualCouponLeaflet.fromJson(item))
          .toList()
          : null,
      bottleConceptionCount: parseInt(json['bottle_conseption_count']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pending_coupons': pendingCoupons,
      'digital_coupons': digitalCoupons,
      'manual_coupons': manualCoupons,
      'manual_coupon_leaflets': manualCouponLeaflets
          ?.map((item) => item.toJson())
          .toList(),
      'bottle_conseption_count': bottleConceptionCount,
    };
  }
}

class ManualCouponLeaflet {
  final String? couponleafletId;
  final String? leafletNumber;
  final String? leafletName;
  final bool? used;

  ManualCouponLeaflet({
    this.couponleafletId,
    this.leafletNumber,
    this.leafletName,
    this.used,
  });

  factory ManualCouponLeaflet.fromJson(Map<String, dynamic> json) {
    return ManualCouponLeaflet(
      couponleafletId: parseString(json['couponleaflet_id']),
      leafletNumber: parseString(json['leaflet_number']),
      leafletName: parseString(json['leaflet_name']),
      used: parseBool(json['used']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'couponleaflet_id': couponleafletId,
      'leaflet_number': leafletNumber,
      'leaflet_name': leafletName,
      'used': used,
    };
  }
}
