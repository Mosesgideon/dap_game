import 'package:dap_game/features/notifications/data/models/get_notifications_response.dart';

abstract class NotificationsRepository {
  Future<GetNotificationsResponse> getNotifications();

  Future<dynamic> showNotification(String id);

  Future<dynamic> readNotification(String id);

  Future<dynamic> markAllAsRead();
}
