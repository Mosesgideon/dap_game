import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/services/network/url_config.dart';
import 'package:dap_game/features/notifications/data/models/get_notifications_response.dart';
import 'package:dap_game/features/notifications/dormain/repository/notifications_repository.dart';


class NotificationsRepositoryImpl extends NotificationsRepository {
  final NetworkService _networkService;

  NotificationsRepositoryImpl(this._networkService);

  @override
  Future<GetNotificationsResponse> getNotifications() async {
    try {
      final response = await _networkService.call(
        UrlConfig.getNotifications,
        RequestMethod.get,
      );
      // return response.data;
      return GetNotificationsResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      rethrow;
    }
  }

  @override
  Future<dynamic> showNotification(String id) async {
    try {
      final response = await _networkService.call(
        UrlConfig.signUp,
        RequestMethod.get,
      );
      return response.data;
      // return GetNotificationsResponse.fromJson(response.data);
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future readNotification(String id) async {
    try {
      final response = await _networkService.call(
        UrlConfig.signUp,
        RequestMethod.post,
      );
      return response.data;
      // return GetNotificationsResponse.fromJson(response.data);
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future markAllAsRead() async {
    try {
      final response = await _networkService.call(
        UrlConfig.signUp,
        RequestMethod.get,
      );

      return response.data;
      // return GetNotificationsResponse.fromJson(response.data);
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }
}
