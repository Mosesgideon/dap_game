// To parse this JSON data, do
//
//     final getDrawResultResponse = getDrawResultResponseFromJson(jsonString);

import 'dart:convert';

import 'package:dap_game/features/games/lottery/data/models/game_winner.dart';

GetDrawResultResponse getDrawResultResponseFromJson(String str) =>
    GetDrawResultResponse.fromJson(json.decode(str));

String getDrawResultResponseToJson(GetDrawResultResponse data) =>
    json.encode(data.toJson());

class GetDrawResultResponse {
  final bool success;
  final String message;
  final Data data;

  GetDrawResultResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  GetDrawResultResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      GetDrawResultResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetDrawResultResponse.fromJson(Map<String, dynamic> json) =>
      GetDrawResultResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };

  List<GameWinner> winners() {
    List<GameWinner> gameWinners = [];

    if (data.draws.result != null) {
      for (var result in data.draws.result!.results) {
        if (result.user != null &&
            gameWinners
                .where((element) => element.username == result.user!.username)
                .isEmpty) {
          gameWinners.add(GameWinner(
              username: result.user!.username,
              image: result.user!.username,
              selection: [],
              timePlayed: DateTime.now(),
              amount: result.amount.toString()));
        }
      }
      for (var gameWinner in gameWinners) {
        gameWinner.selection.addAll(data.draws.result!.results
            .where((element) => element.user?.username == gameWinner.username)
            .map((e) => e.selection));
      }
    }

    return gameWinners;
  }
}

class Data {
  final Draws draws;

  Data({
    required this.draws,
  });

  Data copyWith({
    Draws? draws,
  }) =>
      Data(
        draws: draws ?? this.draws,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        draws: Draws.fromJson(json["draws"]),
      );

  Map<String, dynamic> toJson() => {
        "draws": draws.toJson(),
      };
}

class Draws {
  final int id;
  final DateTime drawDate;
  final int gameId;
  final DateTime startTime;
  final DateTime stopTime;
  final String status;
  final String processed;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DrawsResult? result;

  Draws({
    required this.id,
    required this.drawDate,
    required this.gameId,
    required this.startTime,
    required this.stopTime,
    required this.status,
    required this.processed,
    required this.createdAt,
    required this.updatedAt,
    required this.result,
  });

  Draws copyWith({
    int? id,
    DateTime? drawDate,
    int? gameId,
    DateTime? startTime,
    DateTime? stopTime,
    String? status,
    String? processed,
    DateTime? createdAt,
    DateTime? updatedAt,
    DrawsResult? result,
  }) =>
      Draws(
        id: id ?? this.id,
        drawDate: drawDate ?? this.drawDate,
        gameId: gameId ?? this.gameId,
        startTime: startTime ?? this.startTime,
        stopTime: stopTime ?? this.stopTime,
        status: status ?? this.status,
        processed: processed ?? this.processed,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        result: result ?? this.result,
      );

  factory Draws.fromJson(Map<String, dynamic> json) => Draws(
        id: json["id"],
        drawDate: DateTime.parse(json["draw_date"]),
        gameId: json["game_id"],
        startTime: DateTime.parse(json["start_time"]),
        stopTime: DateTime.parse(json["stop_time"]),
        status: json["status"],
        processed: json["processed"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        result: json["result"] == null
            ? null
            : DrawsResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "draw_date": drawDate.toIso8601String(),
        "game_id": gameId,
        "start_time": startTime.toIso8601String(),
        "stop_time": stopTime.toIso8601String(),
        "status": status,
        "processed": processed,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "result": result?.toJson(),
      };
}

class DrawsResult {
  final int id;
  final String drawId;
  final String gameId;
  final List<ResultElement> results;
  final String totalStake;
  final String amountWon;
  final String potentialWin;
  final DateTime createdAt;
  final DateTime updatedAt;

  DrawsResult({
    required this.id,
    required this.drawId,
    required this.gameId,
    required this.results,
    required this.totalStake,
    required this.amountWon,
    required this.potentialWin,
    required this.createdAt,
    required this.updatedAt,
  });

  DrawsResult copyWith({
    int? id,
    String? drawId,
    String? gameId,
    List<ResultElement>? results,
    String? totalStake,
    String? amountWon,
    String? potentialWin,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      DrawsResult(
        id: id ?? this.id,
        drawId: drawId ?? this.drawId,
        gameId: gameId ?? this.gameId,
        results: results ?? this.results,
        totalStake: totalStake ?? this.totalStake,
        amountWon: amountWon ?? this.amountWon,
        potentialWin: potentialWin ?? this.potentialWin,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory DrawsResult.fromJson(Map<String, dynamic> json) => DrawsResult(
        id: json["id"],
        drawId: json["draw_id"],
        gameId: json["game_id"],
        results: List<ResultElement>.from(
            json["results"].map((x) => ResultElement.fromJson(x))),
        totalStake: json["total_stake"],
        amountWon: json["amount_won"],
        potentialWin: json["potential_win"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "draw_id": drawId,
        "game_id": gameId,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_stake": totalStake,
        "amount_won": amountWon,
        "potential_win": potentialWin,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ResultElement {
  final String selection;
  final int amount;
  final int? userId;
  final Winner? user;
  final bool won;

  ResultElement({
    required this.selection,
    required this.amount,
    required this.userId,
    required this.user,
    required this.won,
  });

  ResultElement copyWith({
    String? selection,
    int? amount,
    int? userId,
    Winner? user,
    bool? won,
  }) =>
      ResultElement(
        selection: selection ?? this.selection,
        amount: amount ?? this.amount,
        userId: userId ?? this.userId,
        user: user ?? this.user,
        won: won ?? this.won,
      );

  factory ResultElement.fromJson(Map<String, dynamic> json) => ResultElement(
        selection: json["selection"],
        amount: json["amount"],
        userId: json["user_id"],
        user: json["user"] == null ? null : Winner.fromJson(json["user"]),
        won: json["won"],
      );

  Map<String, dynamic> toJson() => {
        "selection": selection,
        "amount": amount,
        "user_id": userId,
        "user": user?.toJson(),
        "won": won,
      };
}

class Winner {
  final int id;
  final dynamic firstname;
  final dynamic lastname;
  final String username;
  final String profilePhoto;

  Winner({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.profilePhoto,
  });

  Winner copyWith({
    int? id,
    dynamic firstname,
    dynamic lastname,
    String? username,
    String? profilePhoto,
  }) =>
      Winner(
        id: id ?? this.id,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        username: username ?? this.username,
        profilePhoto: profilePhoto ?? this.profilePhoto,
      );

  factory Winner.fromJson(Map<String, dynamic> json) => Winner(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        profilePhoto: json["profile_photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "profile_photo": profilePhoto,
      };
}
