part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class ContactSupportLoadingState extends SettingsState {}

class ContactSupportFailedState extends SettingsState {
  final String error;

  ContactSupportFailedState(this.error);
}

class ContactSupportSuccessState extends SettingsState {
  final dynamic response;

  ContactSupportSuccessState(this.response);
}
