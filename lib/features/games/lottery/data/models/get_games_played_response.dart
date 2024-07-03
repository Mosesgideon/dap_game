// To parse this JSON data, do
//
//     final getGamesPlayedResponse = getGamesPlayedResponseFromJson(jsonString);

import 'dart:convert';

GetGamesPlayedResponse getGamesPlayedResponseFromJson(String str) => GetGamesPlayedResponse.fromJson(json.decode(str));

String getGamesPlayedResponseToJson(GetGamesPlayedResponse data) => json.encode(data.toJson());

class GetGamesPlayedResponse {
  final bool success;
  final String message;
  final Data data;

  GetGamesPlayedResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  GetGamesPlayedResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      GetGamesPlayedResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetGamesPlayedResponse.fromJson(Map<String, dynamic> json) => GetGamesPlayedResponse(
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
  final List<dynamic> data;
  final String firstPageUrl;
  final dynamic from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final dynamic nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final dynamic to;
  final int total;

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
    List<dynamic>? data,
    String? firstPageUrl,
    dynamic from,
    int? lastPage,
    String? lastPageUrl,
    List<Link>? links,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    dynamic to,
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
    data: List<dynamic>.from(json["data"].map((x) => x)),
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
    "data": List<dynamic>.from(data.map((x) => x)),
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
