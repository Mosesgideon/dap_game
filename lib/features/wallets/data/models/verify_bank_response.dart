// To parse this JSON data, do
//
//     final verifyBankAccountResponse = verifyBankAccountResponseFromJson(jsonString);

import 'dart:convert';

VerifyBankAccountResponse verifyBankAccountResponseFromJson(String str) => VerifyBankAccountResponse.fromJson(json.decode(str));

String verifyBankAccountResponseToJson(VerifyBankAccountResponse data) => json.encode(data.toJson());

class VerifyBankAccountResponse {
  final String status;
  final String message;
  final Data data;

  VerifyBankAccountResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory VerifyBankAccountResponse.fromJson(Map<String, dynamic> json) => VerifyBankAccountResponse(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final String accountNumber;
  final String accountName;

  Data({
    required this.accountNumber,
    required this.accountName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accountNumber: json["account_number"],
    accountName: json["account_name"],
  );

  Map<String, dynamic> toJson() => {
    "account_number": accountNumber,
    "account_name": accountName,
  };
}
