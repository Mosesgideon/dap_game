// To parse this JSON data, do
//
//     final checkUserNameResponse = checkUserNameResponseFromJson(jsonString);

import 'dart:convert';

CheckUserNameResponse checkUserNameResponseFromJson(String str) => CheckUserNameResponse.fromJson(json.decode(str));

String checkUserNameResponseToJson(CheckUserNameResponse data) => json.encode(data.toJson());

class CheckUserNameResponse {
  final bool success;
  final String message;
  final List<dynamic> data;

  CheckUserNameResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  CheckUserNameResponse copyWith({
    bool? success,
    String? message,
    List<dynamic>? data,
  }) =>
      CheckUserNameResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory CheckUserNameResponse.fromJson(Map<String, dynamic> json) => CheckUserNameResponse(
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
