// To parse this JSON data, do
//
//     final getLotteryGamesPlayedResponse = getLotteryGamesPlayedResponseFromJson(jsonString);

import 'dart:convert';

GetLotteryGamesPlayedResponse getLotteryGamesPlayedResponseFromJson(String str) => GetLotteryGamesPlayedResponse.fromJson(json.decode(str));

String getLotteryGamesPlayedResponseToJson(GetLotteryGamesPlayedResponse data) => json.encode(data.toJson());

class GetLotteryGamesPlayedResponse {
  final bool success;
  final String message;
  final Data data;

  GetLotteryGamesPlayedResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  GetLotteryGamesPlayedResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      GetLotteryGamesPlayedResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetLotteryGamesPlayedResponse.fromJson(Map<String, dynamic> json) => GetLotteryGamesPlayedResponse(
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
  final Games games;

  Data({
    required this.games,
  });

  Data copyWith({
    Games? games,
  }) =>
      Data(
        games: games ?? this.games,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    games: Games.fromJson(json["games"]),
  );

  Map<String, dynamic> toJson() => {
    "games": games.toJson(),
  };
}

class Games {
  final int currentPage;
  final List<LotteryGame> data;
  final String firstPageUrl;
  final dynamic from;
  final dynamic lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final dynamic nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final dynamic to;
  final dynamic total;

  Games({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  Games copyWith({
    int? currentPage,
    List<LotteryGame>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Link>? links,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) =>
      Games(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        links: links ?? this.links,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory Games.fromJson(Map<String, dynamic> json) => Games(
    currentPage: json["current_page"],
    data: List<LotteryGame>.from(json["data"].map((x) => LotteryGame.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class LotteryGame {
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

  LotteryGame({
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

  LotteryGame copyWith({
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
      LotteryGame(
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

  factory LotteryGame.fromJson(Map<String, dynamic> json) => LotteryGame(
    id: json["id"],
    userId: json["user_id"],
    gameId: json["game_id"],
    drawId: json["draw_id"],
    amountStaked: json["amount_staked"],
    bonus: json["bonus"],
    amountWon: json["amount_won"],
    potentialWin: json["potential_win"],
    gamesPlayed: List<GamesPlayed>.from(json["games_played"].map((x) => GamesPlayed.fromJson(x))),
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

class Link {
  final String? url;
  final String label;
  final bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) =>
      Link(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
