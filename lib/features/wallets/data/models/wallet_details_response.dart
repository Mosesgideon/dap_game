// To parse this JSON data, do
//
//     final walletDetailsResponse = walletDetailsResponseFromJson(jsonString);

import 'dart:convert';

WalletDetailsResponse walletDetailsResponseFromJson(String str) => WalletDetailsResponse.fromJson(json.decode(str));

String walletDetailsResponseToJson(WalletDetailsResponse data) => json.encode(data.toJson());

class WalletDetailsResponse {
  final bool success;
  final String message;
  final Data data;

  WalletDetailsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory WalletDetailsResponse.fromJson(Map<String, dynamic> json) => WalletDetailsResponse(
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
  final Wallet wallet;
  final List<WalletTransaction> transactions;

  Data({
    required this.wallet,
    required this.transactions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    wallet: Wallet.fromJson(json["wallet"]),
    transactions: List<WalletTransaction>.from(json["transactions"].map((x) => WalletTransaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "wallet": wallet.toJson(),
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
  };
}

class WalletTransaction {
  final int id;
  final int walletId;
  final int userId;
  final String amount;
  final String type;
  final String channel;
  final dynamic purpose;
  final DateTime createdAt;
  final DateTime updatedAt;

  WalletTransaction({
    required this.id,
    required this.walletId,
    required this.userId,
    required this.amount,
    required this.type,
    required this.channel,
    required this.purpose,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WalletTransaction.fromJson(Map<String, dynamic> json) => WalletTransaction(
    id: json["id"],
    walletId: json["wallet_id"],
    userId: json["user_id"],
    amount: json["amount"],
    type: json["type"],
    channel: json["channel"],
    purpose: json["purpose"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "wallet_id": walletId,
    "user_id": userId,
    "amount": amount,
    "type": type,
    "channel": channel,
    "purpose": purpose,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Wallet {
  final int id;
  final String userId;
  final String balance;
  final String isEligible;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Wallet({
    required this.id,
    required this.userId,
    required this.balance,
    required this.isEligible,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    id: json["id"],
    userId: json["user_id"],
    balance: json["balance"],
    isEligible: json["is_eligible"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "balance": balance,
    "is_eligible": isEligible,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
