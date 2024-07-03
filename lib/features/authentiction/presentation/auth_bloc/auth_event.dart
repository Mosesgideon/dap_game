part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {}

class SignInEvent extends AuthEvent {
  final String user_id;
  final String password;

  SignInEvent(this.user_id, this.password);

  @override
  List<Object?> get props => [user_id, password];
}

class SignUpEvent extends AuthEvent {
  RegisterPayload payload;

  SignUpEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}

class GoogleSignInEvent extends AuthEvent {
  DateTime? dob;

  GoogleSignInEvent({this.dob});

  @override
  List<Object?> get props => [];
}

class AppleSignInEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends AuthEvent {
  String email;

  SendOtpEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class VerifyOtpEvent extends AuthEvent {
  final String otp;
  final String email;

  VerifyOtpEvent({required this.otp, required this.email});

  @override
  List<Object?> get props => [otp, email];
}

class CreateNewPasswordEvent extends AuthEvent {
  final String newPassword;
  final String password_confirmation;
  final String email;

  CreateNewPasswordEvent(
      {required this.password_confirmation,
      required this.newPassword,
      required this.email});

  @override
  List<Object?> get props => [newPassword, email, password_confirmation];
}
