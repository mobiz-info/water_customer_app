import 'package:hive_flutter/hive_flutter.dart';
import 'package:water_customer_app/Models/parser_helper/parser_helper.dart';

class EmirateLocationModel {
  bool? status;
  List<EmirateLocationData>? data;
  String? message;

  EmirateLocationModel({this.status, this.data, this.message});

  factory EmirateLocationModel.fromJson(Map<String, dynamic> json) {
    return EmirateLocationModel(
      status: parseBool(json['status']),
      data: (json['data'] as List<dynamic>?)
          ?.map((v) => EmirateLocationData.fromJson(v))
          .toList(),
      message: parseString(json['message']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((v) => v.toJson()).toList(),
      'message': message,
    };
  }
}

class EmirateLocationData {
  String? emirateId;
  String? name;
  List<Locations>? locations;

  EmirateLocationData({this.emirateId, this.name, this.locations});

  factory EmirateLocationData.fromJson(Map<String, dynamic> json) {
    return EmirateLocationData(
      emirateId: parseString(json['emirate_id']),
      name: parseString(json['name']),
      locations: (json['locations'] as List<dynamic>?)
          ?.map((v) => Locations.fromJson(v))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emirate_id': emirateId,
      'name': name,
      'locations': locations?.map((v) => v.toJson()).toList(),
    };
  }
}

class Locations {
  String? locationId;
  String? createdBy;
  String? createdDate;
  String? modifiedBy;
  String? modifiedDate;
  String? locationName;
  String? emirate;
  String? branchId;

  Locations({
    this.locationId,
    this.createdBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
    this.locationName,
    this.emirate,
    this.branchId,
  });

  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(
      locationId: parseString(json['location_id']),
      createdBy: parseString(json['created_by']),
      createdDate: parseString(json['created_date']),
      modifiedBy: parseString(json['modified_by']),
      modifiedDate: parseString(json['modified_date']),
      locationName: parseString(json['location_name']),
      emirate: parseString(json['emirate']),
      branchId: parseString(json['branch_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location_id': locationId,
      'created_by': createdBy,
      'created_date': createdDate,
      'modified_by': modifiedBy,
      'modified_date': modifiedDate,
      'location_name': locationName,
      'emirate': emirate,
      'branch_id': branchId,
    };
  }
}
