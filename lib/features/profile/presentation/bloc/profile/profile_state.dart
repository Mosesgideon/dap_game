part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {}

class ProfileInitial extends ProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileSuccessState extends ProfileState {
  ProfileResponse response;
  ProfileSuccessState(this.response);
  @override
  List<Object?> get props => [];
}

class ProfileUpdateSuccessState extends ProfileState {
  UpdateProfileResponse response;

  ProfileUpdateSuccessState(this.response);

  @override
  List<Object?> get props => [];
}

class ProfileFailureState extends ProfileState {
  String error;

  ProfileFailureState(this.error);

  @override
  List<Object?> get props => [];
}

class DeleteAccountLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class DeleteAccountSuccessState extends ProfileState {
  DeleteAccountResponse response;
  DeleteAccountSuccessState(this.response);
  @override
  List<Object?> get props => [response];
}

class DeleteAccountFailureState extends ProfileState {
  String error;

  DeleteAccountFailureState(this.error);

  @override
  List<Object?> get props => [];
}
