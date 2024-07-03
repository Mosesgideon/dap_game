import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/games/lottery/data/models/get_games_categories_models.dart';
import 'package:dap_game/features/games/shared/dormain/repository/games_repository.dart';
import 'package:equatable/equatable.dart';

part 'games_event.dart';

part 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final GamesRepository _gameRepository;

  GamesBloc(this._gameRepository) : super(GamesInitial()) {
    on<GetGamesCategoryEvent>(_mapGetGamesCategoryEventToState);
  }

  Future<void> _mapGetGamesCategoryEventToState(
    GetGamesCategoryEvent event,
    Emitter<GamesState> emit,
  ) async {
    emit(const GameLoadingState());
    try {
      final GetGamesCategoryResponse response =
          await _gameRepository.getGamesCategory();
      emit(GamesCategoryLoadedState(response));
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);

      emit(GameFailureState(e.toString()));
    }
  }
}
