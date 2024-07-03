class LeaderBoardResponse {
  bool? success;
  String? message;
  Data? data;

  LeaderBoardResponse({this.success, this.message, this.data});

  LeaderBoardResponse.fromJson(Map<String, dynamic> json) {
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
  List<Leaders>? leaders;

  Data({this.leaders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['leaders'] != null) {
      leaders = <Leaders>[];
      json['leaders'].forEach((v) {
        leaders!.add(new Leaders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaders != null) {
      data['leaders'] = this.leaders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leaders {
  int? userId;
  String? totalAmountWon;
  User? user;

  Leaders({this.userId, this.totalAmountWon, this.user});

  Leaders.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    totalAmountWon = json['total_amount_won'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['total_amount_won'] = this.totalAmountWon;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? firstname;
  String? lastname;
  String? email;
  String? profilePhoto;

  User(
      {this.id,
      this.username,
      this.firstname,
      this.lastname,
      this.email,
      this.profilePhoto});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}
