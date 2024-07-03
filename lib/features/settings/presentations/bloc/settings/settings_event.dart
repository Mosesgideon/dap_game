part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class ContactSupportEvent extends SettingsEvent {
  final String subject;
  final String message;

  ContactSupportEvent(this.subject, this.message);
}
