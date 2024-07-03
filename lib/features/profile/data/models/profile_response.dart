// To parse this JSON data, do
//
//     final profiletResponse = profiletResponseFromJson(jsonString);

import 'dart:convert';

import 'package:dap_game/features/authentiction/data/models/auth_success_rsponse.dart';

ProfileResponse profiletResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profiletResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

class ProfileResponse {
  final bool success;
  final String message;
  final Data data;

  ProfileResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  ProfileResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      ProfileResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final DapGameUser user;

  Data({
    required this.user,
  });

  Data copyWith({
    DapGameUser? user,
  }) =>
      Data(
        user: user ?? this.user,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: DapGameUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}



class Wallet {
  final int id;
  final String balance;
  final String isEligible;
  final String status;
  final String userId;

  Wallet({
    required this.id,
    required this.balance,
    required this.isEligible,
    required this.status,
    required this.userId,
  });

  Wallet copyWith({
    int? id,
    String? balance,
    String? isEligible,
    String? status,
    String? userId,
  }) =>
      Wallet(
        id: id ?? this.id,
        balance: balance ?? this.balance,
        isEligible: isEligible ?? this.isEligible,
        status: status ?? this.status,
        userId: userId ?? this.userId,
      );

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        balance: json["balance"],
        isEligible: json["is_eligible"],
        status: json["status"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "balance": balance,
        "is_eligible": isEligible,
        "status": status,
        "user_id": userId,
      };
}
