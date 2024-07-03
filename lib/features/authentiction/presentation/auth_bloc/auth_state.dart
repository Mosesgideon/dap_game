part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccessState extends AuthState {
  AuthSuccessResponse response;

  AuthSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class AuthFailureState extends AuthState {
  String error;

  AuthFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class AuthGoogleLoagingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthGoogleSuccessState extends AuthState {
  AuthSuccessResponse response;

  AuthGoogleSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class AuthGoogleFailureState extends AuthState {
  String error;

  AuthGoogleFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class OtpSentSuccessState extends AuthState {
  OtpSentSuccessState();

  @override
  List<Object?> get props => [];
}

class OtpVerificationSuccessState extends AuthState {
  @override
  List<Object?> get props => [];
}

class PasswordChangeSuccessState extends AuthState {
  @override
  List<Object?> get props => [];
}
