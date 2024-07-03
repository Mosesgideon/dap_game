// To parse this JSON data, do
//
//     final playGamePayload = playGamePayloadFromJson(jsonString);

import 'dart:convert';

PlayGamePayload playGamePayloadFromJson(String str) =>
    PlayGamePayload.fromJson(json.decode(str));

String playGamePayloadToJson(PlayGamePayload data) =>
    json.encode(data.toJson());

class PlayGamePayload {
  final int gameId;
  final int drawId;
  final List<dynamic> selection;
  final double amount;

  PlayGamePayload({
    required this.gameId,
    required this.drawId,
    required this.selection,
    required this.amount,
  });

  PlayGamePayload copyWith({
    int? gameId,
    int? drawId,
    List<dynamic>? selection,
    double? amount,
  }) =>
      PlayGamePayload(
        gameId: gameId ?? this.gameId,
        drawId: drawId ?? this.drawId,
        selection: selection ?? this.selection,
        amount: amount ?? this.amount,
      );

  factory PlayGamePayload.fromJson(Map<String, dynamic> json) =>
      PlayGamePayload(
        gameId: json["game_id"],
        drawId: json["draw_id"],
        selection: List<dynamic>.from(json["selection"].map((x) => x)),
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "game_id": gameId,
        "draw_id": drawId,
        "selection": List<dynamic>.from(selection.map((x) => x.toString())),
        "amount": amount,
      };
}
