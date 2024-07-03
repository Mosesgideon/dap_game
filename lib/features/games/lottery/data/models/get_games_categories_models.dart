// To parse this JSON data, do
//
//     final getGamesCategoryResponse = getGamesCategoryResponseFromJson(jsonString);

import 'dart:convert';

GetGamesCategoryResponse getGamesCategoryResponseFromJson(String str) =>
    GetGamesCategoryResponse.fromJson(json.decode(str));

String getGamesCategoryResponseToJson(GetGamesCategoryResponse data) =>
    json.encode(data.toJson());

class GetGamesCategoryResponse {
  final bool success;
  final String message;
  final Data data;

  GetGamesCategoryResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  GetGamesCategoryResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      GetGamesCategoryResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetGamesCategoryResponse.fromJson(Map<String, dynamic> json) =>
      GetGamesCategoryResponse(
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
  final List<GameCategory> games;

  Data({
    required this.games,
  });

  Data copyWith({
    List<GameCategory>? games,
  }) =>
      Data(
        games: games ?? this.games,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        games: List<GameCategory>.from(
            json["games"].map((x) => GameCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "games": List<dynamic>.from(games.map((x) => x.toJson())),
      };
}

class GameCategory {
  final int id;
  final String category;
  final String type;
  final String path;
  final String posterImg;
  final String promptText;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<DapGame> games;

  GameCategory({
    required this.id,
    required this.category,
    required this.type,
    required this.path,
    required this.posterImg,
    required this.promptText,
    required this.createdAt,
    required this.updatedAt,
    required this.games,
  });

  GameCategory copyWith({
    int? id,
    String? category,
    String? type,
    String? path,
    String? posterImg,
    String? promptText,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<DapGame>? games,
  }) =>
      GameCategory(
        id: id ?? this.id,
        category: category ?? this.category,
        type: type ?? this.type,
        path: path ?? this.path,
        posterImg: posterImg ?? this.posterImg,
        promptText: promptText ?? this.promptText,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        games: games ?? this.games,
      );

  factory GameCategory.fromJson(Map<String, dynamic> json) => GameCategory(
        id: json["id"],
        category: json["category"],
        type: json["type"],
        path: json["path"],
        posterImg: json["poster_img"],
        promptText: json["prompt_text"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        games:
            List<DapGame>.from(json["games"].map((x) => DapGame.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "type": type,
        "path": path,
        "poster_img": posterImg,
        "prompt_text": promptText,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "games": List<dynamic>.from(games.map((x) => x.toJson())),
      };
}

class DapGame {
  final int id;
  final String name;
  final String uniqueName;
  final dynamic categoryId;
  final String drawType;
  final String duration;
  final DateTime? startTime;
  final DateTime? stopTime;
  final String path;
  final String posterImg;
  final dynamic promptText;
  final String amountPerStake;
  final String potentialWin;
  final String currency;
  final String instructions;
  final dynamic hint;
  final DateTime createdAt;
  final DateTime updatedAt;

  DapGame({
    required this.id,
    required this.name,
    required this.uniqueName,
    required this.categoryId,
    required this.drawType,
    required this.duration,
    required this.startTime,
    required this.stopTime,
    required this.path,
    required this.posterImg,
    required this.promptText,
    required this.amountPerStake,
    required this.potentialWin,
    required this.currency,
    required this.instructions,
    required this.hint,
    required this.createdAt,
    required this.updatedAt,
  });

  DapGame copyWith({
    int? id,
    String? name,
    String? uniqueName,
    String? categoryId,
    String? drawType,
    String? duration,
    DateTime? startTime,
    DateTime? stopTime,
    String? path,
    String? posterImg,
    dynamic promptText,
    String? amountPerStake,
    String? potentialWin,
    String? currency,
    String? instructions,
    dynamic hint,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      DapGame(
        id: id ?? this.id,
        name: name ?? this.name,
        uniqueName: uniqueName ?? this.uniqueName,
        categoryId: categoryId ?? this.categoryId,
        drawType: drawType ?? this.drawType,
        duration: duration ?? this.duration,
        startTime: startTime ?? this.startTime,
        stopTime: stopTime ?? this.stopTime,
        path: path ?? this.path,
        posterImg: posterImg ?? this.posterImg,
        promptText: promptText ?? this.promptText,
        amountPerStake: amountPerStake ?? this.amountPerStake,
        potentialWin: potentialWin ?? this.potentialWin,
        currency: currency ?? this.currency,
        instructions: instructions ?? this.instructions,
        hint: hint ?? this.hint,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory DapGame.fromJson(Map<String, dynamic> json) => DapGame(
        id: json["id"],
        name: json["name"],
        uniqueName: json["unique_name"],
        categoryId: json["category_id"],
        drawType: json["draw_type"],
        duration: json["duration"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        stopTime: json["stop_time"] == null
            ? null
            : DateTime.parse(json["stop_time"]),
        path: json["path"],
        posterImg: json["poster_img"],
        promptText: json["prompt_text"],
        amountPerStake: json["amount_per_stake"],
        potentialWin: json["potential_win"],
        currency: json["currency"],
        instructions: json["instructions"],
        hint: json["hint"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "unique_name": uniqueName,
        "category_id": categoryId,
        "draw_type": drawType,
        "duration": duration,
        "start_time": startTime?.toIso8601String(),
        "stop_time": stopTime?.toIso8601String(),
        "path": path,
        "poster_img": posterImg,
        "prompt_text": promptText,
        "amount_per_stake": amountPerStake,
        "potential_win": potentialWin,
        "currency": currency,
        "instructions": instructions,
        "hint": hint,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
