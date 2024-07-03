part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {}

class GetProfileEvent extends ProfileEvent {
  GetProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileUpdatedEvent extends ProfileEvent {
  String? username;
  String? phonNumber;
  String? country;
  String? firstname;
  String? lastname;
  String? coverimage;
  String? profileimage;
  String? dob;
  String? password;
  String? oldPassword;

  ProfileUpdatedEvent(
      {this.country,
      this.phonNumber,
      this.lastname,
      this.coverimage,
      this.profileimage,
      this.firstname,
      this.username,
      this.dob,
      this.password,
      this.oldPassword});

  @override
  List<Object?> get props => [];
}

class AccountDeleteEvent extends ProfileEvent {
  DeletAccountPayload payload;

  AccountDeleteEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}
