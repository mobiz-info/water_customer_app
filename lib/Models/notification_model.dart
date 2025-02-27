import 'package:hive_flutter/hive_flutter.dart';

part 'notification_model.g.dart';

@HiveType(typeId: 1)
class NotificationModel {
  NotificationModel({
    required this.status,
    required this.data,
  });
  @HiveField(0)
  final String? status;
  @HiveField(1)
  final Data? data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

@HiveType(typeId: 2)
class Data {
  Data({
    required this.time,
    required this.title,
    required this.messaage,
  });
  @HiveField(0)
  final String? time;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? messaage;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      time: json["time"],
      title: json["title"],
      messaage: json["messaage"],
    );
  }
}
