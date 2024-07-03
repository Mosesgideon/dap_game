// To parse this JSON data, do
//
//     final getCountryGameDrawResponse = getCountryGameDrawResponseFromJson(jsonString);

import 'dart:convert';

GetCountryGameDrawResponse getCountryGameDrawResponseFromJson(String str) => GetCountryGameDrawResponse.fromJson(json.decode(str));

String getCountryGameDrawResponseToJson(GetCountryGameDrawResponse data) => json.encode(data.toJson());

class GetCountryGameDrawResponse {
  final bool success;
  final String message;
  final Data data;

  GetCountryGameDrawResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  GetCountryGameDrawResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      GetCountryGameDrawResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetCountryGameDrawResponse.fromJson(Map<String, dynamic> json) => GetCountryGameDrawResponse(
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
  final Draw draw;

  Data({
    required this.draw,
  });

  Data copyWith({
    Draw? draw,
  }) =>
      Data(
        draw: draw ?? this.draw,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    draw: Draw.fromJson(json["draw"]),
  );

  Map<String, dynamic> toJson() => {
    "draw": draw.toJson(),
  };
}

class Draw {
  final int id;
  final DateTime drawDate;
  final int gameId;
  final DateTime startTime;
  final DateTime stopTime;
  final List<GameCountry> gameData;
  final dynamic selection;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Draw({
    required this.id,
    required this.drawDate,
    required this.gameId,
    required this.startTime,
    required this.stopTime,
    required this.gameData,
    required this.selection,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Draw copyWith({
    int? id,
    DateTime? drawDate,
    int? gameId,
    DateTime? startTime,
    DateTime? stopTime,
    List<GameCountry>? gameData,
    dynamic selection,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Draw(
        id: id ?? this.id,
        drawDate: drawDate ?? this.drawDate,
        gameId: gameId ?? this.gameId,
        startTime: startTime ?? this.startTime,
        stopTime: stopTime ?? this.stopTime,
        gameData: gameData ?? this.gameData,
        selection: selection ?? this.selection,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Draw.fromJson(Map<String, dynamic> json) => Draw(
    id: json["id"],
    drawDate: DateTime.parse(json["draw_date"]),
    gameId: json["game_id"],
    startTime: DateTime.parse(json["start_time"]),
    stopTime: DateTime.parse(json["stop_time"]),
    gameData: List<GameCountry>.from(json["game_data"].map((x) => GameCountry.fromJson(x))),
    selection: json["selection"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "draw_date": drawDate.toIso8601String(),
    "game_id": gameId,
    "start_time": startTime.toIso8601String(),
    "stop_time": stopTime.toIso8601String(),
    "game_data": List<dynamic>.from(gameData.map((x) => x.toJson())),
    "selection": selection,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class GameCountry {
  final int id;
  final String name;
  final String capital;
  final String phone;
  final String code;
  final String countryFlag;

  GameCountry({
    required this.id,
    required this.name,
    required this.capital,
    required this.phone,
    required this.code,
    required this.countryFlag,
  });

  GameCountry copyWith({
    int? id,
    String? name,
    String? capital,
    String? phone,
    String? code,
    String? countryFlag,
  }) =>
      GameCountry(
        id: id ?? this.id,
        name: name ?? this.name,
        capital: capital ?? this.capital,
        phone: phone ?? this.phone,
        code: code ?? this.code,
        countryFlag: countryFlag ?? this.countryFlag,
      );

  factory GameCountry.fromJson(Map<String, dynamic> json) => GameCountry(
    id: json["id"],
    name: json["name"],
    capital: json["capital"],
    phone: json["phone"],
    code: json["code"],
    countryFlag: json["country_flag"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "capital": capital,
    "phone": phone,
    "code": code,
    "country_flag": countryFlag,
  };
}
