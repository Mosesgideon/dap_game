import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/profile/data/models/delete_account_payload.dart';
import 'package:dap_game/features/profile/data/models/delete_account_response.dart';
import 'package:dap_game/features/profile/data/models/profile_response.dart';
import 'package:dap_game/features/profile/data/models/update_profile_response.dart';
import 'package:dap_game/features/profile/domain/repository/account_repository.dart';
import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AccountRepository _repository;

  ProfileBloc(this._repository) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<GetProfileEvent>(_mapProfileEventToState);
    on<ProfileUpdatedEvent>(_mapProfileUpdateEventToState);
    on<AccountDeleteEvent>(_mapAccountDeleteEventToState);
  }

  Future<FutureOr<void>> _mapProfileEventToState(
      GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      var response = await _repository.profileAccount();
      injector.get<UserBloc>().add(SaveUserEvent(response.data.user));
      emit(ProfileSuccessState(response));
    } catch (e) {
      logger.e(e.toString());
    }
  }

  FutureOr<void> _mapProfileUpdateEventToState(
      ProfileUpdatedEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());
      var response = await _repository.updateProfile(
          event.username,
          event.coverimage,
          event.phonNumber,
          event.country,
          event.firstname,
          event.lastname,
          event.profileimage,
          event.dob);
      injector.get<UserBloc>().add(SaveUserEvent(response.data.user));
      emit(ProfileUpdateSuccessState(response));
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<FutureOr<void>> _mapAccountDeleteEventToState(
      AccountDeleteEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(DeleteAccountLoadingState());
      var response = await _repository.deleteAccount(event.payload);
      emit(DeleteAccountSuccessState(response));
    } catch (e) {
      logger.e(e.toString());
      emit(DeleteAccountFailureState(e.toString()));
      // TODO
    }
  }
}
