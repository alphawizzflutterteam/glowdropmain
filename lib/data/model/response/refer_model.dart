// To parse this JSON data, do
//
//     final referModel = referModelFromJson(jsonString);

import 'dart:convert';

ReferModel referModelFromJson(String str) =>
    ReferModel.fromJson(json.decode(str));

String referModelToJson(ReferModel data) => json.encode(data.toJson());

class ReferModel {
  bool status;
  String message;
  ReferData data;

  ReferModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ReferModel.fromJson(Map<String, dynamic> json) => ReferModel(
        status: json["status"],
        message: json["message"],
        data: ReferData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class ReferData {
  String name;
  String phone;
  String email;
  String referralCode;

  ReferData({
    required this.name,
    required this.phone,
    required this.email,
    required this.referralCode,
  });

  factory ReferData.fromJson(Map<String, dynamic> json) => ReferData(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        referralCode: json["referral_code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "referral_code": referralCode,
      };
}
