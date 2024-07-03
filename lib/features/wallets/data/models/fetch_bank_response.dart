class FetchBankResponse {
  FetchBankResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final String? status;
  final String? message;
  final List<BankData> data;

  factory FetchBankResponse.fromJson(Map<String, dynamic> json){
    return FetchBankResponse(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<BankData>.from(json["data"]!.map((x) => BankData.fromJson(x))),
    );
  }

}

class BankData {
  BankData({
    required this.id,
    required this.code,
    required this.name,
  });

  final int? id;
  final String? code;
  final String? name;

  factory BankData.fromJson(Map<String, dynamic> json){
    return BankData(
      id: json["id"],
      code: json["code"],
      name: json["name"],
    );
  }

}
