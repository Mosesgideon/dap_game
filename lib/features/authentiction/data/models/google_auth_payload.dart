// To parse this JSON data, do
//
//     final googleSignInPayload = googleSignInPayloadFromJson(jsonString);

import 'dart:convert';

GoogleSignInPayload googleSignInPayloadFromJson(String str) =>
    GoogleSignInPayload.fromJson(json.decode(str));

String googleSignInPayloadToJson(GoogleSignInPayload data) =>
    json.encode(data.toJson());

class GoogleSignInPayload {
  final String googleId;
  final String username;
  final String email;
  final String firstname;
  final String lastname;
  final String referral;
  final String deviceToken;
  final String devicePlatform;
  final DateTime? dob;

  GoogleSignInPayload({
    required this.googleId,
    required this.username,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.referral,
    required this.deviceToken,
    required this.devicePlatform,
    required this.dob,
  });

  GoogleSignInPayload copyWith({
    String? googleId,
    String? username,
    String? email,
    String? firstname,
    String? lastname,
    String? referral,
    String? deviceToken,
    String? devicePlatform,
    final DateTime? dob

  }) =>
      GoogleSignInPayload(
        googleId: googleId ?? this.googleId,
        username: username ?? this.username,
        email: email ?? this.email,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        referral: referral ?? this.referral,
        deviceToken: deviceToken ?? this.deviceToken,
        devicePlatform: devicePlatform ?? this.devicePlatform,
        dob: dob ?? this.dob,
      );

  factory GoogleSignInPayload.fromJson(Map<String, dynamic> json) =>
      GoogleSignInPayload(
        googleId: json["google_id"],
        username: json["username"],
        email: json["email"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        referral: json["referral"],
        deviceToken: json["device_token"],
        devicePlatform: json["device_platform"],
        dob: json["dob"],
      );

  Map<String, dynamic> toJson() => {
        "google_id": googleId,
        "username": username,
        "email": email,
        "firstname": firstname,
        "lastname": lastname,
        "referral": referral,
        "device_token": deviceToken,
        "dob": dob?.toIso8601String(),
        "device_platform": devicePlatform,
      };
}
