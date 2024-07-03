import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/leaderboard/data/models/leaderboard_response.dart';
import 'package:dap_game/features/leaderboard/repository/leaderboad_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'leaderboard_event.dart';

part 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final LeaderBoardRepository _leaderboardRepository;

  LeaderboardBloc(this._leaderboardRepository) : super(LeaderboardInitial()) {
    on<LeaderboardEvent>((event, emit) {});

    on<LeaderBoardFetchedEvent>(_mapLeaderBoardEventToState);
  }

  Future<FutureOr<void>> _mapLeaderBoardEventToState(
      LeaderBoardFetchedEvent event, Emitter<LeaderboardState> emit) async {
    emit(LeaderBoardLoadingState());
    try {
      var response = await _leaderboardRepository.leaderboard(event.gameId);
      emit(LeaderBoardSuccessState(response));
    } catch (e) {
      emit(LeaderBoardFailureState(e.toString()));
      logger.e(e.toString());
      // TODO
    }
  }
}
