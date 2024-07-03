// To parse this JSON data, do
//
//     final gameDetailResponse = gameDetailResponseFromJson(jsonString);

import 'dart:convert';

GameDetailResponse gameDetailResponseFromJson(String str) =>
    GameDetailResponse.fromJson(json.decode(str));

String gameDetailResponseToJson(GameDetailResponse data) =>
    json.encode(data.toJson());

class GameDetailResponse {
  final bool success;
  final String message;
  final Data data;

  GameDetailResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  GameDetailResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      GameDetailResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GameDetailResponse.fromJson(Map<String, dynamic> json) =>
      GameDetailResponse(
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
  final int id;
  final int userId;
  final int gameId;
  final int drawId;
  final String amountStaked;
  final String bonus;
  final String amountWon;
  final String potentialWin;
  final List<GamesPlayed> gamesPlayed;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Draw draw;

  PlayedGame({
    required this.id,
    required this.userId,
    required this.gameId,
    required this.drawId,
    required this.amountStaked,
    required this.bonus,
    required this.amountWon,
    required this.potentialWin,
    required this.gamesPlayed,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.draw,
  });

  PlayedGame copyWith({
    int? id,
    int? userId,
    int? gameId,
    int? drawId,
    String? amountStaked,
    String? bonus,
    String? amountWon,
    String? potentialWin,
    List<GamesPlayed>? gamesPlayed,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Draw? draw,
  }) =>
      PlayedGame(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        gameId: gameId ?? this.gameId,
        drawId: drawId ?? this.drawId,
        amountStaked: amountStaked ?? this.amountStaked,
        bonus: bonus ?? this.bonus,
        amountWon: amountWon ?? this.amountWon,
        potentialWin: potentialWin ?? this.potentialWin,
        gamesPlayed: gamesPlayed ?? this.gamesPlayed,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        draw: draw ?? this.draw,
      );

  factory PlayedGame.fromJson(Map<String, dynamic> json) => PlayedGame(
        id: json["id"],
        userId: json["user_id"],
        gameId: json["game_id"],
        drawId: json["draw_id"],
        amountStaked: json["amount_staked"],
        bonus: json["bonus"],
        amountWon: json["amount_won"],
        potentialWin: json["potential_win"],
        gamesPlayed: List<GamesPlayed>.from(
            json["games_played"].map((x) => GamesPlayed.fromJson(x))),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        draw: Draw.fromJson(json["draw"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "game_id": gameId,
        "draw_id": drawId,
        "amount_staked": amountStaked,
        "bonus": bonus,
        "amount_won": amountWon,
        "potential_win": potentialWin,
        "games_played": List<dynamic>.from(gamesPlayed.map((x) => x.toJson())),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "draw": draw.toJson(),
      };
}

class Draw {
  final int id;
  final int gameId;
  final DateTime drawDate;
  final DateTime startTime;
  final DateTime stopTime;
  final String status;

  Draw({
    required this.id,
    required this.gameId,
    required this.drawDate,
    required this.startTime,
    required this.stopTime,
    required this.status,
  });

  Draw copyWith({
    int? id,
    int? gameId,
    DateTime? drawDate,
    DateTime? startTime,
    DateTime? stopTime,
    String? status,
  }) =>
      Draw(
        id: id ?? this.id,
        gameId: gameId ?? this.gameId,
        drawDate: drawDate ?? this.drawDate,
        startTime: startTime ?? this.startTime,
        stopTime: stopTime ?? this.stopTime,
        status: status ?? this.status,
      );

  factory Draw.fromJson(Map<String, dynamic> json) => Draw(
        id: json["id"],
        gameId: json["game_id"],
        drawDate: DateTime.parse(json["draw_date"]),
        startTime: DateTime.parse(json["start_time"]),
        stopTime: DateTime.parse(json["stop_time"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "game_id": gameId,
        "draw_date": drawDate.toIso8601String(),
        "start_time": startTime.toIso8601String(),
        "stop_time": stopTime.toIso8601String(),
        "status": status,
      };
}

class GamesPlayed {
  final String selection;
  final int amountWon;
  final String status;

  GamesPlayed({
    required this.selection,
    required this.amountWon,
    required this.status,
  });

  GamesPlayed copyWith({
    String? selection,
    int? amountWon,
    String? status,
  }) =>
      GamesPlayed(
        selection: selection ?? this.selection,
        amountWon: amountWon ?? this.amountWon,
        status: status ?? this.status,
      );

  factory GamesPlayed.fromJson(Map<String, dynamic> json) => GamesPlayed(
        selection: json["selection"],
        amountWon: json["amount_won"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "selection": selection,
        "amount_won": amountWon,
        "status": status,
      };
}
