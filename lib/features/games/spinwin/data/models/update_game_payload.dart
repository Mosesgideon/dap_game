// To parse this JSON data, do
//
//     final updateGamePayload = updateGamePayloadFromJson(jsonString);

import 'dart:convert';

UpdateGamePayload updateGamePayloadFromJson(String str) => UpdateGamePayload.fromJson(json.decode(str));

String updateGamePayloadToJson(UpdateGamePayload data) => json.encode(data.toJson());

class UpdateGamePayload {
  final int playId;
  final String playStatus;
  final int amount;

  UpdateGamePayload({
    required this.playId,
    required this.playStatus,
    required this.amount,
  });

  factory UpdateGamePayload.fromJson(Map<String, dynamic> json) => UpdateGamePayload(
    playId: json["play_id"],
    playStatus: json["play_status"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "play_id": playId,
    "play_status": playStatus,
    "amount": amount,
  };
}
