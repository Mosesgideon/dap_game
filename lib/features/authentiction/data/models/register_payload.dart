// To parse this JSON data, do
//
//     final registerPayload = registerPayloadFromJson(jsonString);

import 'dart:convert';

RegisterPayload registerPayloadFromJson(String str) =>
    RegisterPayload.fromJson(json.decode(str));

String registerPayloadToJson(RegisterPayload data) =>
    json.encode(data.toJson());

class RegisterPayload {
  final String username;
  final String email;
  final String password;
  final String referral;
  final String deviceToken;
  final String devicePlatform;
  final DateTime dob;

  RegisterPayload({
    required this.username,
    required this.email,
    required this.password,
    required this.referral,
    required this.deviceToken,
    required this.devicePlatform,
    required this.dob,
  });

  RegisterPayload copyWith({
    String? username,
    String? email,
    String? password,
    String? referral,
    String? deviceToken,
    String? devicePlatform,
    DateTime? dob,
  }) =>
      RegisterPayload(
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        referral: referral ?? this.referral,
        deviceToken: deviceToken ?? this.deviceToken,
        devicePlatform: devicePlatform ?? this.devicePlatform,
        dob: dob ?? this.dob,
      );

  factory RegisterPayload.fromJson(Map<String, dynamic> json) =>
      RegisterPayload(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        referral: json["referral"],
        deviceToken: json["device_token"],
        devicePlatform: json["device_platform"],
        dob: json["dob"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "referral": referral,
        "device_token": deviceToken,
        "device_platform": devicePlatform,
        "dob": dob.toIso8601String(),
      };
}
