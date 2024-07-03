// To parse this JSON data, do
//
//     final deleteAccountResponse = deleteAccountResponseFromJson(jsonString);

import 'dart:convert';

DeleteAccountResponse deleteAccountResponseFromJson(String str) =>
    DeleteAccountResponse.fromJson(json.decode(str));

String deleteAccountResponseToJson(DeleteAccountResponse data) =>
    json.encode(data.toJson());

class DeleteAccountResponse {
  final bool success;
  final String message;
  final List<dynamic> data;

  DeleteAccountResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  DeleteAccountResponse copyWith({
    bool? success,
    String? message,
    List<dynamic>? data,
  }) =>
      DeleteAccountResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory DeleteAccountResponse.fromJson(Map<String, dynamic> json) =>
      DeleteAccountResponse(
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
