// To parse this JSON data, do
//
//     final gameDrawsResponse = gameDrawsResponseFromJson(jsonString);

import 'dart:convert';

GameDrawsResponse gameDrawsResponseFromJson(String str) =>
    GameDrawsResponse.fromJson(json.decode(str));

String gameDrawsResponseToJson(GameDrawsResponse data) =>
    json.encode(data.toJson());

class GameDrawsResponse {
  final bool success;
  final String message;
  final Data data;

  GameDrawsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  GameDrawsResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      GameDrawsResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GameDrawsResponse.fromJson(Map<String, dynamic> json) =>
      GameDrawsResponse(
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
  final List<LotteryDraw> draws;

  Data({
    required this.draws,
  });

  Data copyWith({
    List<LotteryDraw>? draws,
  }) =>
      Data(
        draws: draws ?? this.draws,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        draws: List<LotteryDraw>.from(
            json["draws"].map((x) => LotteryDraw.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "draws": List<dynamic>.from(draws.map((x) => x.toJson())),
      };
}

class LotteryDraw {
  final int id;
  final DateTime drawDate;
  final int gameId;
  final DateTime startTime;
  final DateTime stopTime;
  final List<int> gameData;
  final dynamic selection;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  LotteryDraw({
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

  LotteryDraw copyWith({
    int? id,
    DateTime? drawDate,
    int? gameId,
    DateTime? startTime,
    DateTime? stopTime,
    List<int>? gameData,
    dynamic selection,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      LotteryDraw(
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

  factory LotteryDraw.fromJson(Map<String, dynamic> json) => LotteryDraw(
        id: json["id"],
        drawDate: DateTime.parse(json["draw_date"]),
        gameId: json["game_id"],
        startTime: DateTime.parse(json["start_time"]),
        stopTime: DateTime.parse(json["stop_time"]),
        gameData: json["game_data"] == null
            ? []
            : List<int>.from(json["game_data"].map((x) => x)),
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
        "game_data": List<dynamic>.from(gameData.map((x) => x)),
        "selection": selection,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
