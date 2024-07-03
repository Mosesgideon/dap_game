import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/games/lottery/data/models/game_details_response.dart';
import 'package:dap_game/features/games/lottery/data/models/game_draws_response.dart';
import 'package:dap_game/features/games/lottery/data/models/game_result_response.dart';
import 'package:dap_game/features/games/lottery/data/models/get_country_game_draw_response.dart';
import 'package:dap_game/features/games/lottery/data/models/get_lucky_numbers_draw_response.dart';
import 'package:dap_game/features/games/lottery/data/models/get_number_games_played.dart';
import 'package:dap_game/features/games/lottery/data/models/play_game_payload.dart';
import 'package:dap_game/features/games/lottery/data/models/play_game_response.dart';
import 'package:dap_game/features/games/lottery/dormain/repository/lottery_game_repository.dart';
import 'package:equatable/equatable.dart';

part 'lottery_game_event.dart';

part 'lottery_game_state.dart';

class LotteryGameBloc extends Bloc<LotteryGameEvent, LotteryGameState> {
  final LotteryGameRepository _repository;

  LotteryGameBloc(this._repository) : super(GetCountryDrawsLFailed()) {
    on<LotteryGameEvent>((event, emit) {});
    on<GetCountryDrawsEvent>(_mapGetCountryDrawsToState);
    on<GetLuckyNumbersDrawsEvent>(_mapGetLuckyNumbersDrawsEventToState);
    on<PlayGameEvent>(_mapPlayGameEventToState);
    on<GetGamesPlayedEvent>(_mapGetGamesPlayedEventToState);
    on<GetGamesDetailsEvent>(_mapGetGamesDetailsEventToState);
    on<GetGameDrawsEvent>(_mapGetGameDrawsEventToState);
    on<GetDrawResultEvent>(_mapGGetDrawResultEventToState);
  }

  FutureOr<void> _mapGetCountryDrawsToState(
      GetCountryDrawsEvent event, Emitter<LotteryGameState> emit) async {
    emit(GetCountryDrawsLoading());
    try {
      var response = await _repository.getCountryDraw(event.id);
      emit(GetCountryGamesSuccessState(response));
    } catch (e) {
      emit(GetCountryDrawsLFailed());
    }
  }

  FutureOr<void> _mapGetLuckyNumbersDrawsEventToState(
      GetLuckyNumbersDrawsEvent event, Emitter<LotteryGameState> emit) async {
    emit(GetLuckyNumbersDrawLoading());
    try {
      var response = await _repository.getNumberDraw(event.id);
      emit(GetLuckyNumbersDrawSuccessState(response));
    } catch (e, stack) {
      logger.w(stack);
      logger.w(e);
      emit(GetLuckyNumbersDrawLFailed(e.toString()));
    }
  }

  FutureOr<void> _mapPlayGameEventToState(
      PlayGameEvent event, Emitter<LotteryGameState> emit) async {
    emit(PlayGameLoadingState());
    try {
      var response = await _repository.playCountryGame(event.payload);
      emit(PlayGameSuccessState(response));
    } catch (e, stack) {
      logger.i(stack);
      emit(PlayGameFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapGetGamesPlayedEventToState(
      GetGamesPlayedEvent event, Emitter<LotteryGameState> emit) async {
    emit(GamesPlayedLoading());
    try {
      var response = await _repository.getNumbersGamePlayed(event.gameId);
      emit(GamesPlayedSuccessState(response));
    } catch (e, stack) {
      logger.e(stack.toString());
      emit(GamesPlayedFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapGetGamesDetailsEventToState(
      GetGamesDetailsEvent event, Emitter<LotteryGameState> emit) async {
    emit(GamesDetailsLoading());
    try {
      var response = await _repository.getGameDetails(event.gameId);
      emit(GamesDetailsSuccessState(response));
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      emit(GamesDetailsFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapGGetDrawResultEventToState(
      GetDrawResultEvent event, Emitter<LotteryGameState> emit) async {
    emit(GetDrawResultsLoading());
    try {
      var response = await _repository.getDrawResult(event.drawId);
      emit(GetDrawResultsSuccessState(response));
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      emit(GetDrawResultsFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapGetGameDrawsEventToState(
      GetGameDrawsEvent event, Emitter<LotteryGameState> emit) async {
    emit(GetGameDrawsLoading());
    try {
      var response = await _repository.getGameDraws(event.gameId);
      emit(GetGameDrawsSuccessState(response));
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      emit(GetGameDrawsFailureState(e.toString()));
    }
  }
}
