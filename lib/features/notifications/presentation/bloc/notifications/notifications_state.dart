part of 'notifications_bloc.dart';

abstract class NotificationState {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class GetNotificationsLoadingState extends NotificationState {
  @override
  List<Object?> get props => [];
}

class GetNotificationsSuccessState extends NotificationState {
  final GetNotificationsResponse response;

  GetNotificationsSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetNotificationsFailureState extends NotificationState {
  final String error;

  const GetNotificationsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class ReadNotificationLoadingState extends NotificationState {
  @override
  List<Object?> get props => [];
}

class ReadNotificationSuccessState extends NotificationState {
  final dynamic response;

  const ReadNotificationSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class ReadNotificationFailureState extends NotificationState {
  final String error;

  ReadNotificationFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class ShowNotificationLoadingState extends NotificationState {
  @override
  List<Object?> get props => [];
}

class ShowNotificationSuccessState extends NotificationState {
  final dynamic response;

  ShowNotificationSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class ShowNotificationFailureState extends NotificationState {
  final String error;

  ShowNotificationFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class ReadAllNotificationsLoading extends NotificationState {
  @override
  List<Object?> get props => [];
}

class ReadAllNotificationsSuccessState extends NotificationState {
  final dynamic response;

  const ReadAllNotificationsSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class ReadAllNotificationsFailureState extends NotificationState {
  final String error;

  const ReadAllNotificationsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
