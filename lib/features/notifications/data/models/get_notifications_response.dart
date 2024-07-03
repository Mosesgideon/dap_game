// To parse this JSON data, do
//
//     final getNotificationsResponse = getNotificationsResponseFromJson(jsonString);

import 'dart:convert';

GetNotificationsResponse getNotificationsResponseFromJson(String str) =>
    GetNotificationsResponse.fromJson(json.decode(str));

String getNotificationsResponseToJson(GetNotificationsResponse data) =>
    json.encode(data.toJson());

class GetNotificationsResponse {
  final bool success;
  final String message;
  final GetNotificationsResponseData data;

  GetNotificationsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  GetNotificationsResponse copyWith({
    bool? success,
    String? message,
    GetNotificationsResponseData? data,
  }) =>
      GetNotificationsResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetNotificationsResponse.fromJson(Map<String, dynamic> json) =>
      GetNotificationsResponse(
        success: json["success"],
        message: json["message"],
        data: GetNotificationsResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class GetNotificationsResponseData {
  final List<AppNotification> notifications;

  GetNotificationsResponseData({
    required this.notifications,
  });

  GetNotificationsResponseData copyWith({
    List<AppNotification>? notifications,
  }) =>
      GetNotificationsResponseData(
        notifications: notifications ?? this.notifications,
      );

  factory GetNotificationsResponseData.fromJson(Map<String, dynamic> json) =>
      GetNotificationsResponseData(
        notifications: List<AppNotification>.from(
            json["notifications"].map((x) => AppNotification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
      };
}

class AppNotification {
  final String id;
  final String type;
  final String notifiableType;
  final String notifiableId;
  final NotificationData data;
   dynamic readAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppNotification({
    required this.id,
    required this.type,
    required this.notifiableType,
    required this.notifiableId,
    required this.data,
    required this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  AppNotification copyWith({
    String? id,
    String? type,
    String? notifiableType,
    String? notifiableId,
    NotificationData? data,
    dynamic readAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      AppNotification(
        id: id ?? this.id,
        type: type ?? this.type,
        notifiableType: notifiableType ?? this.notifiableType,
        notifiableId: notifiableId ?? this.notifiableId,
        data: data ?? this.data,
        readAt: readAt ?? this.readAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory AppNotification.fromJson(Map<String, dynamic> json) => AppNotification(
        id: json["id"],
        type: json["type"],
        notifiableType: json["notifiable_type"],
        notifiableId: json["notifiable_id"],
        data: NotificationData.fromJson(json["data"]),
        readAt: json["read_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "notifiable_type": notifiableType,
        "notifiable_id": notifiableId,
        "data": data.toJson(),
        "read_at": readAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class NotificationData {
  final String type;
  final String message;
  final Content content;
  final int myUserId;

  NotificationData({
    required this.type,
    required this.message,
    required this.content,
    required this.myUserId,
  });

  NotificationData copyWith({
    String? type,
    String? message,
    Content? content,
    int? myUserId,
  }) =>
      NotificationData(
        type: type ?? this.type,
        message: message ?? this.message,
        content: content ?? this.content,
        myUserId: myUserId ?? this.myUserId,
      );

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        type: json["type"],
        message: json["message"],
        content: Content.fromJson(json["content"]),
        myUserId: json["my_user_id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "content": content.toJson(),
        "my_user_id": myUserId,
      };
}

class Content {
  final Notifier notifier;
  final dynamic dataId;

  Content({
    required this.notifier,
    required this.dataId,
  });

  Content copyWith({
    Notifier? notifier,
    dynamic dataId,
  }) =>
      Content(
        notifier: notifier ?? this.notifier,
        dataId: dataId ?? this.dataId,
      );

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        notifier: Notifier.fromJson(json["notifier"]),
        dataId: json["data_id"],
      );

  Map<String, dynamic> toJson() => {
        "notifier": notifier.toJson(),
        "data_id": dataId,
      };
}

class Notifier {
  final int id;
  final String name;
  final String avatar;

  Notifier({
    required this.id,
    required this.name,
    required this.avatar,
  });

  Notifier copyWith({
    int? id,
    String? name,
    String? avatar,
  }) =>
      Notifier(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
      );

  factory Notifier.fromJson(Map<String, dynamic> json) => Notifier(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
      };
}
