class BeneficiaryResponse {
  bool? success;
  String? message;
  Data? data;

  BeneficiaryResponse({this.success, this.message, this.data});

  BeneficiaryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Beneficary>? beneficaries;

  Data({this.beneficaries});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['beneficaries'] != null) {
      beneficaries = <Beneficary>[];
      json['beneficaries'].forEach((v) {
        beneficaries!.add(new Beneficary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.beneficaries != null) {
      data['beneficaries'] = this.beneficaries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Beneficary {
  int? id;
  String? userId;
  String? countryCode;
  String? bankCode;
  String? bankName;
  String? accountNo;
  String? accountName;
  String? label;
  String? createdAt;
  String? updatedAt;

  Beneficary(
      {this.id,
        this.userId,
        this.countryCode,
        this.bankCode,
        this.bankName,
        this.accountNo,
        this.accountName,
        this.label,
        this.createdAt,
        this.updatedAt});

  Beneficary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    countryCode = json['country_code'];
    bankCode = json['bank_code'];
    bankName = json['bank_name'];
    accountNo = json['account_no'];
    accountName = json['account_name'];
    label = json['label'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['country_code'] = this.countryCode;
    data['bank_code'] = this.bankCode;
    data['bank_name'] = this.bankName;
    data['account_no'] = this.accountNo;
    data['account_name'] = this.accountName;
    data['label'] = this.label;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
