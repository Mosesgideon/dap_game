// To parse this JSON data, do
//
//     final playGameResponse = playGameResponseFromJson(jsonString);

import 'dart:convert';

SpinGamePlayedResponse playGameResponseFromJson(String str) =>
    SpinGamePlayedResponse.fromJson(json.decode(str));

String playGameResponseToJson(SpinGamePlayedResponse data) =>
    json.encode(data.toJson());

class SpinGamePlayedResponse {
  final bool success;
  final String message;
  final Data data;

  SpinGamePlayedResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SpinGamePlayedResponse.fromJson(Map<String, dynamic> json) =>
      SpinGamePlayedResponse(
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
  final CurrentGame currentGame;

  Data({
    required this.currentGame,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentGame: CurrentGame.fromJson(json["current_game"]),
      );

  Map<String, dynamic> toJson() => {
        "current_game": currentGame.toJson(),
      };
}

class CurrentGame {
  final dynamic userId;
  final dynamic gameId;
  final dynamic amountStaked;
  final String potentialWin;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;
  final int dailyPlay;

  CurrentGame({
    required this.userId,
    required this.gameId,
    required this.amountStaked,
    required this.potentialWin,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.dailyPlay,
  });

  factory CurrentGame.fromJson(Map<String, dynamic> json) => CurrentGame(
        userId: json["user_id"],
        gameId: json["game_id"],
        amountStaked: json["amount_staked"],
        potentialWin: json["potential_win"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        dailyPlay: json["daily_play"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "game_id": gameId,
        "amount_staked": amountStaked,
        "potential_win": potentialWin,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "daily_play": dailyPlay,
      };
}
