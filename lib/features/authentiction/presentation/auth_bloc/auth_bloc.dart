import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/authentiction/data/models/auth_success_rsponse.dart';
import 'package:dap_game/features/authentiction/data/models/register_payload.dart';
import 'package:dap_game/features/authentiction/domain/repository/authrepository.dart';
import 'package:dap_game/features/authentiction/domain/usecase/auth_success_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SignInEvent>(_mapSignInEventToState);
    on<SignUpEvent>(_mapSignUpEventToState);
    on<SendOtpEvent>(_mapSendOtpEventToState);
    on<VerifyOtpEvent>(_mapVerifyOtpEventToState);
    on<CreateNewPasswordEvent>(_mapNewPasswordEventToStat);
    on<GoogleSignInEvent>(_mapGoogleSignInEventToState);
  }

  FutureOr<void> _mapSignInEventToState(
      SignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());
      final response = await _repository.login(event.user_id, event.password);
      AuthSuccessUseCase().execute(response);
      emit(AuthSuccessState(response));
    } catch (e, stack) {
      emit(AuthFailureState(error: e.toString()));
      logger.e(stack.toString());
      logger.e(e.toString() ?? "login failed");
    }
  }

  Future<FutureOr<void>> _mapSignUpEventToState(
      SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());
      var response = await _repository.register(event.payload);
      AuthSuccessUseCase().execute(response);
      emit(AuthSuccessState(response));
    } catch (e, stack) {
      logger.e(stack.toString());
      logger.e(e.toString() ?? "signup failed");
      emit(AuthFailureState(error: e.toString()));
      // TODO
    }
  }

  Future<FutureOr<void>> _mapSendOtpEventToState(
      SendOtpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());
      var response = await _repository.sendOtp(event.email);
      emit(OtpSentSuccessState());
      log("sent");
    } catch (e, stack) {
      logger.e(stack.toString());
      logger.e(e.toString() ?? "sendOTP failed");
      emit(AuthFailureState(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _mapVerifyOtpEventToState(
      VerifyOtpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());
      var response = await _repository.verifyOtp(
        event.otp,
        event.email,
      ); // Pass token here
      emit(OtpVerificationSuccessState());
    } catch (e, stack) {
      emit(AuthFailureState(error: e.toString()));
      logger.e(e.toString());
      logger.e(stack.toString());
    }
  }

  Future<FutureOr<void>> _mapNewPasswordEventToStat(
      CreateNewPasswordEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());
      var response = await _repository.createNewPassword(
          email: event.email,
          newPassword: event.newPassword,
          password_confirmation: event.password_confirmation);
      log(event.email);
      log(event.newPassword);
      emit(PasswordChangeSuccessState());
    } catch (e) {
      logger.e(e.toString());
      emit(AuthFailureState(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _mapGoogleSignInEventToState(
      GoogleSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthGoogleLoagingState());
    try {
      var response = await _repository.authenticateWithGoogle(dob: event.dob);
      AuthSuccessUseCase().execute(response);

      emit(AuthGoogleSuccessState(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(AuthFailureState(error: e.toString()));
    }
  }
}
