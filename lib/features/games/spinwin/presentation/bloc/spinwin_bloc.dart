import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/games/lottery/data/models/play_game_response.dart';
import 'package:dap_game/features/games/spinwin/data/models/play_game_response.dart';
import 'package:dap_game/features/games/spinwin/data/models/update_game_payload.dart';
import 'package:dap_game/features/games/spinwin/dormain/repository/spin_win_repository.dart';
import 'package:dap_game/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:equatable/equatable.dart';

part 'spinwin_event.dart';

part 'spinwin_state.dart';

class SpinwinBloc extends Bloc<SpinwinEvent, SpinwinState> {
  final SpinWinRepository _repository;

  SpinwinBloc(this._repository) : super(SpinwinInitial()) {
    on<PlayGameEvent>(_mapPlayGameEventToState);
    on<UpdateGameEvent>(_mapUpdateGameEventToState);

    on<SpinwinEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  FutureOr<void> _mapPlayGameEventToState(
      PlayGameEvent event, Emitter<SpinwinState> emit) async {
    try {
      emit(PlayGameLoadingState());
      final response = await _repository.playGame();

      emit(PlayGameSuccessState(response));
    } catch (e) {
      emit(PlayGameFailedState(e.toString()));
    }
  }

  FutureOr<void> _mapUpdateGameEventToState(
      UpdateGameEvent event, Emitter<SpinwinState> emit) async {
    try {
      emit(UpdateGameLoadingState());
      final response = await _repository.updateGame(event.payload);

      injector.get<ProfileBloc>().add(GetProfileEvent());
      emit(UpdateGameSuccessState(response));
    } catch (e) {
      emit(UpdateGameFailedState(e.toString()));
    }
  }
}
