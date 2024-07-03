import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dap_game/features/notifications/data/models/get_notifications_response.dart';
import 'package:dap_game/features/notifications/dormain/repository/notifications_repository.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

// Bloc class
class NotificationsBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationsRepository _notificationRepository;

  List<AppNotification> allNotifications = [];

  NotificationsBloc(this._notificationRepository)
      : super(NotificationInitial()) {
    on<GetNotificationsEvent>(_mapGetNotificationsEventToState);
    on<ReadNotificationEvent>(_mapReadNotificationEventToState);
    on<ShowNotificationEvent>(_mapShowNotificationEventToState);
    on<MarkAllAsReadEvent>(_mapMarkAllAsReadEventToState);
  }

  Future<void> _mapGetNotificationsEventToState(
    GetNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(GetNotificationsLoadingState());
    try {
      final response = await _notificationRepository.getNotifications();
      allNotifications = response.data.notifications;
      emit(GetNotificationsSuccessState(response: response));
    } catch (e) {
      emit(GetNotificationsFailureState(error: e.toString()));
    }
  }

  Future<void> _mapReadNotificationEventToState(
    ReadNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(ReadNotificationLoadingState());
    try {
      final response = await _notificationRepository.readNotification(event.id);
      emit(ReadNotificationSuccessState(response: response));
    } catch (e) {
      emit(ReadNotificationFailureState(error: e.toString()));
    }
  }

  Future<void> _mapShowNotificationEventToState(
    ShowNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    allNotifications.where((element) => element.id == event.id).first.readAt =
        DateTime.now();

    emit(ShowNotificationLoadingState());
    try {
      final response = await _notificationRepository.showNotification(event.id);
      emit(ShowNotificationSuccessState(response: response));
    } catch (e) {
      emit(ShowNotificationFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapMarkAllAsReadEventToState(
      MarkAllAsReadEvent event, Emitter<NotificationState> emit) async {
    emit(ReadAllNotificationsLoading());
    try {
      final response = await _notificationRepository.markAllAsRead();
      emit(ReadAllNotificationsSuccessState(response: response));
    } catch (e) {
      emit(ReadAllNotificationsFailureState(error: e.toString()));
    }
  }
}
