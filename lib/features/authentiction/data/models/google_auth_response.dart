// To parse this JSON data, do
//
//     final googleSignInResponse = googleSignInResponseFromJson(jsonString);

import 'dart:convert';

GoogleSignInResponse googleSignInResponseFromJson(String str) =>
    GoogleSignInResponse.fromJson(json.decode(str));

String googleSignInResponseToJson(GoogleSignInResponse data) =>
    json.encode(data.toJson());

class GoogleSignInResponse {
  final bool success;
  final String message;
  final Data data;

  GoogleSignInResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  GoogleSignInResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      GoogleSignInResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GoogleSignInResponse.fromJson(Map<String, dynamic> json) =>
      GoogleSignInResponse(
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
  final User user;
  final String bearerToken;

  Data({
    required this.user,
    required this.bearerToken,
  });

  Data copyWith({
    User? user,
    String? bearerToken,
  }) =>
      Data(
        user: user ?? this.user,
        bearerToken: bearerToken ?? this.bearerToken,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        bearerToken: json["bearer_token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "bearer_token": bearerToken,
      };
}

class User {
  final int id;
  final String username;
  final String email;
  final String firstname;
  final String lastname;
  final dynamic phone;
  final dynamic country;
  final dynamic state;
  final dynamic city;
  final dynamic dob;
  final String coverPhoto;
  final String profilePhoto;
  final String referralId;
  final dynamic referral;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Wallet wallet;

  User({
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
  });

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? firstname,
    String? lastname,
    dynamic phone,
    dynamic country,
    dynamic state,
    dynamic city,
    dynamic dob,
    String? coverPhoto,
    String? profilePhoto,
    String? referralId,
    dynamic referral,
    DateTime? createdAt,
    DateTime? updatedAt,
    Wallet? wallet,
  }) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        phone: phone ?? this.phone,
        country: country ?? this.country,
        state: state ?? this.state,
        city: city ?? this.city,
        dob: dob ?? this.dob,
        coverPhoto: coverPhoto ?? this.coverPhoto,
        profilePhoto: profilePhoto ?? this.profilePhoto,
        referralId: referralId ?? this.referralId,
        referral: referral ?? this.referral,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        wallet: wallet ?? this.wallet,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
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
