// To parse this JSON data, do
//
//     final getLuckyNumbersDrawResponse = getLuckyNumbersDrawResponseFromJson(jsonString);

import 'dart:convert';

GetLuckyNumbersDrawResponse getLuckyNumbersDrawResponseFromJson(String str) =>
    GetLuckyNumbersDrawResponse.fromJson(json.decode(str));

String getLuckyNumbersDrawResponseToJson(GetLuckyNumbersDrawResponse data) =>
    json.encode(data.toJson());

class GetLuckyNumbersDrawResponse {
  final bool success;
  final String message;
  final Data data;

  GetLuckyNumbersDrawResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  GetLuckyNumbersDrawResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      GetLuckyNumbersDrawResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetLuckyNumbersDrawResponse.fromJson(Map<String, dynamic> json) =>
      GetLuckyNumbersDrawResponse(
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
  final dynamic startTime;
  final DateTime stopTime;
  final List<int> gameData;
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
    List<int>? gameData,
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
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        stopTime: DateTime.parse(json["stop_time"]),
        gameData: List<int>.from(json["game_data"].map((x) => x)),
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
