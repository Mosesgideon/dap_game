// To parse this JSON data, do
//
//     final makeWithdrawalResponse = makeWithdrawalResponseFromJson(jsonString);

import 'dart:convert';

MakeWithdrawalResponse makeWithdrawalResponseFromJson(String str) => MakeWithdrawalResponse.fromJson(json.decode(str));

String makeWithdrawalResponseToJson(MakeWithdrawalResponse data) => json.encode(data.toJson());

class MakeWithdrawalResponse {
  final bool success;
  final String message;
  final Data data;

  MakeWithdrawalResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory MakeWithdrawalResponse.fromJson(Map<String, dynamic> json) => MakeWithdrawalResponse(
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
  final Withdrawal withdrawal;

  Data({
    required this.withdrawal,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    withdrawal: Withdrawal.fromJson(json["withdrawal"]),
  );

  Map<String, dynamic> toJson() => {
    "withdrawal": withdrawal.toJson(),
  };
}

class Withdrawal {
  final int walletId;
  final dynamic userId;
  final dynamic amount;
  final dynamic beneficiaryId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Withdrawal({
    required this.walletId,
    required this.userId,
    required this.amount,
    required this.beneficiaryId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Withdrawal.fromJson(Map<String, dynamic> json) => Withdrawal(
    walletId: json["wallet_id"],
    userId: json["user_id"],
    amount: json["amount"],
    beneficiaryId: json["beneficiary_id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "wallet_id": walletId,
    "user_id": userId,
    "amount": amount,
    "beneficiary_id": beneficiaryId,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
