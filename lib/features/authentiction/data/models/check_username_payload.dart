// To parse this JSON data, do
//
//     final checkUserNameResponse = checkUserNameResponseFromJson(jsonString);

import 'dart:convert';

CheckUserNameResponse checkUserNameResponseFromJson(String str) =>
    CheckUserNameResponse.fromJson(json.decode(str));

String checkUserNameResponseToJson(CheckUserNameResponse data) =>
    json.encode(data.toJson());

class CheckUserNameResponse {
  final String username;

  CheckUserNameResponse({
    required this.username,
  });

  CheckUserNameResponse copyWith({
    String? username,
  }) =>
      CheckUserNameResponse(
        username: username ?? this.username,
      );

  factory CheckUserNameResponse.fromJson(Map<String, dynamic> json) =>
      CheckUserNameResponse(
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
      };
}
