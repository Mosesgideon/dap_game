part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class SaveUserEvent extends UserEvent {
  final DapGameUser appUser;

  const SaveUserEvent(this.appUser);

  @override
  List<Object?> get props => [appUser];
}

class GetUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class ClearUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}
