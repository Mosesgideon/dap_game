// To parse this JSON data, do
//
//     final authSuccessResponse = authSuccessResponseFromJson(jsonString);

import 'dart:convert';

AuthSuccessResponse authSuccessResponseFromJson(String str) => AuthSuccessResponse.fromJson(json.decode(str));

String authSuccessResponseToJson(AuthSuccessResponse data) => json.encode(data.toJson());

class AuthSuccessResponse {
  final bool success;
  final String message;
  final Data data;

  AuthSuccessResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AuthSuccessResponse.fromJson(Map<String, dynamic> json) => AuthSuccessResponse(
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
  final String bearerToken;

  Data({
    required this.user,
    required this.bearerToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: DapGameUser.fromJson(json["user"]),
    bearerToken: json["bearer_token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "bearer_token": bearerToken,
  };
}

class DapGameUser {
  final int id;
  final dynamic username;
  final dynamic email;
  final dynamic firstname;
  final dynamic lastname;
  final dynamic phone;
  final dynamic country;
  final dynamic state;
  final dynamic city;
  final dynamic dob;
  final dynamic coverPhoto;
  final dynamic profilePhoto;
  final dynamic referralId;
  final dynamic referral;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Wallet wallet;
  final Wallet coinWallet;

  DapGameUser({
    required this.id,
    required this.username,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.country,
    required this.state,
    required this.city,
    required this.dob,
    required this.coverPhoto,
    required this.profilePhoto,
    required this.referralId,
    required this.referral,
    required this.createdAt,
    required this.updatedAt,
    required this.wallet,
    required this.coinWallet,
  });

  factory DapGameUser.fromJson(Map<String, dynamic> json) => DapGameUser(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    phone: json["phone"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    dob: json["dob"],
    coverPhoto: json["cover_photo"],
    profilePhoto: json["profile_photo"],
    referralId: json["referral_id"],
    referral: json["referral"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    wallet: Wallet.fromJson(json["wallet"]),
    coinWallet: Wallet.fromJson(json["coin_wallet"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "firstname": firstname,
    "lastname": lastname,
    "phone": phone,
    "country": country,
    "state": state,
    "city": city,
    "dob": dob,
    "cover_photo": coverPhoto,
    "profile_photo": profilePhoto,
    "referral_id": referralId,
    "referral": referral,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "wallet": wallet.toJson(),
    "coin_wallet": coinWallet.toJson(),
  };
}

class Wallet {
  final int id;
  final dynamic balance;
  final dynamic status;
  final dynamic userId;
  final dynamic rate;
  final dynamic? isEligible;

  Wallet({
    required this.id,
    required this.balance,
    required this.status,
    required this.userId,
    required this.rate,
    this.isEligible,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    id: json["id"],
    balance: json["balance"],
    status: json["status"],
    userId: json["user_id"],
    rate: json["rate"],
    isEligible: json["is_eligible"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "balance": balance,
    "status": status,
    "user_id": userId,
    "is_eligible": isEligible,
    "rate": rate,
  };
}
