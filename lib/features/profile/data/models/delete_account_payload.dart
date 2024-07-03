// To parse this JSON data, do
//
//     final deletAccountPayload = deletAccountPayloadFromJson(jsonString);

import 'dart:convert';

DeletAccountPayload deletAccountPayloadFromJson(String str) =>
    DeletAccountPayload.fromJson(json.decode(str));

String deletAccountPayloadToJson(DeletAccountPayload data) =>
    json.encode(data.toJson());

class DeletAccountPayload {
  final String password;
  final String reason;
  final String message;

  DeletAccountPayload({
    required this.password,
    required this.reason,
    required this.message,
  });

  DeletAccountPayload copyWith({
    String? password,
    String? reason,
    String? message,
  }) =>
      DeletAccountPayload(
        password: password ?? this.password,
        reason: reason ?? this.reason,
        message: message ?? this.message,
      );

  factory DeletAccountPayload.fromJson(Map<String, dynamic> json) =>
      DeletAccountPayload(
        password: json["password"],
        reason: json["reason"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "reason": reason,
        "message": message,
      };
}
