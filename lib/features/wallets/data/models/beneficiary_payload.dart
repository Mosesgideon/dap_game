class AddBeneficiaryPaylod {
  String? countryCode;
  String? bankCode;
  String? bankName;
  String? accountNo;
  String? accountName;

  AddBeneficiaryPaylod(
      {this.countryCode,
        this.bankCode,
        this.bankName,
        this.accountNo,
        this.accountName});

  AddBeneficiaryPaylod.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    bankCode = json['bank_code'];
    bankName = json['bank_name'];
    accountNo = json['account_no'];
    accountName = json['account_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['bank_code'] = this.bankCode;
    data['bank_name'] = this.bankName;
    data['account_no'] = this.accountNo;
    data['account_name'] = this.accountName;
    return data;
  }
}
