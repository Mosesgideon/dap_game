// To parse this JSON data, do
//
//     final signOutResponse = signOutResponseFromJson(jsonString);

import 'dart:convert';

SignOutResponse signOutResponseFromJson(String str) =>
    SignOutResponse.fromJson(json.decode(str));

String signOutResponseToJson(SignOutResponse data) =>
    json.encode(data.toJson());

class SignOutResponse {
  final bool success;
  final String message;
  final List<dynamic> data;

  SignOutResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  SignOutResponse copyWith({
    bool? success,
    String? message,
    List<dynamic>? data,
  }) =>
      SignOutResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory SignOutResponse.fromJson(Map<String, dynamic> json) =>
      SignOutResponse(
        success: json["success"],
        message: json["message"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}
