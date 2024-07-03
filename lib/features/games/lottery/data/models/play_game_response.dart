// To parse this JSON data, do
//
//     final allgames = allgamesFromJson(jsonString);

import 'dart:convert';

PlayGameResponse allgamesFromJson(String str) =>
    PlayGameResponse.fromJson(json.decode(str));

String allgamesToJson(PlayGameResponse data) => json.encode(data.toJson());

class PlayGameResponse {
  final bool success;
  final String message;
  final Data data;

  PlayGameResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  PlayGameResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      PlayGameResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory PlayGameResponse.fromJson(Map<String, dynamic> json) =>
      PlayGameResponse(
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
  final PlayedGame playedGame;

  Data({
    required this.playedGame,
  });

  Data copyWith({
    PlayedGame? playedGame,
  }) =>
      Data(
        playedGame: playedGame ?? this.playedGame,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        playedGame: PlayedGame.fromJson(json["played_game"]),
      );

  Map<String, dynamic> toJson() => {
        "played_game": playedGame.toJson(),
      };
}

class PlayedGame {
  final dynamic userId;
  final dynamic drawId;
  final dynamic amount;
  final List gamesPlayed;
  final DateTime updatedAt;
  final DateTime createdAt;
  final dynamic id;

  PlayedGame({
    required this.userId,
    required this.drawId,
    required this.amount,
    required this.gamesPlayed,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  PlayedGame copyWith({
    int? userId,
    int? drawId,
    int? amount,
    List? gamesPlayed,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) =>
      PlayedGame(
        userId: userId ?? this.userId,
        drawId: drawId ?? this.drawId,
        amount: amount ?? this.amount,
        gamesPlayed: gamesPlayed ?? this.gamesPlayed,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory PlayedGame.fromJson(Map<String, dynamic> json) => PlayedGame(
        userId: json["user_id"],
        drawId: json["draw_id"],
        amount: json["amount"],
        gamesPlayed: json["games_played"] == null
            ? []
            : List.from(json["games_played"].map((x) => x)),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "draw_id": drawId,
        "amount": amount,
        "games_played": List<dynamic>.from(gamesPlayed.map((x) => x)),
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
