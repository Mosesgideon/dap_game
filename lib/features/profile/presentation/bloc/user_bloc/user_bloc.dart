import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/authentiction/data/models/auth_success_rsponse.dart';
import 'package:equatable/equatable.dart';
import 'package:dap_game/common/database/local/userstorage.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  Future<void> close() async {}

  DapGameUser? appUser;

  final _userStorage = UserStorage();

  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) {});
    on<SaveUserEvent>(_mapSaveUserEventToState);
    on<GetUserEvent>(_mapGetUserEventToState);
    on<ClearUserEvent>(_mapDeleteUserEventToState);
  }

  FutureOr<void> _mapSaveUserEventToState(
      SaveUserEvent event, Emitter<UserState> emit) {
    _userStorage.saveUser(event.appUser);
    appUser = event.appUser;
    emit(UserCachedState(event.appUser));
  }

  FutureOr<void> _mapGetUserEventToState(
      GetUserEvent event, Emitter<UserState> emit) async {
    var user = await _userStorage.getUser();

    if (user != null) {
      appUser = user;
      emit(UserCachedState(user));
    }
  }

  Future<FutureOr<void>> _mapDeleteUserEventToState(
      ClearUserEvent event, Emitter<UserState> emit) async {
    try {
      var user = await _userStorage.clearUser();
    } catch (e) {
      logger.e(e.toString());
      // TODO
    }
  }
}
