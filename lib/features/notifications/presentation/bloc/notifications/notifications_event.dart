part of 'notifications_bloc.dart';



abstract class NotificationEvent  {
  const NotificationEvent();
}

class GetNotificationsEvent extends NotificationEvent {
  @override
  List<Object?> get props => [];
}

class ReadNotificationEvent extends NotificationEvent {
  final String id;

  const ReadNotificationEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class ShowNotificationEvent extends NotificationEvent {
  final String id;

  const ShowNotificationEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class MarkAllAsReadEvent extends NotificationEvent {
  // final String id;

  const MarkAllAsReadEvent();

  @override
  List<Object?> get props => [];
}
