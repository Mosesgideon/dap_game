class FetchCountriesResponse {
  bool? success;
  String? message;
  Data? data;

  FetchCountriesResponse({this.success, this.message, this.data});

  FetchCountriesResponse.fromJson(Map<String, dynamic> json) {
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
  List<Countries>? countries;

  Data({this.countries});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countries {
  String? name;
  String? capital;
  String? code;
  String? phoneCode;
  String? currency;

  Countries(
      {this.name, this.capital, this.code, this.phoneCode, this.currency});

  Countries.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    capital = json['capital'];
    code = json['code'];
    phoneCode = json['phone_code'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['capital'] = this.capital;
    data['code'] = this.code;
    data['phone_code'] = this.phoneCode;
    data['currency'] = this.currency;
    return data;
  }
}
