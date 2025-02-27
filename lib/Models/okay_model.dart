class OkayModel {
  OkayModel({
    required this.status,
  });

  final String? status;

  factory OkayModel.fromJson(Map<String, dynamic> json) {
    return OkayModel(
      status: json["status"],
    );
  }
}
