part of 'games_bloc.dart';

abstract class GamesState extends Equatable {
  const GamesState();
}

class GamesInitial extends GamesState {
  @override
  List<Object> get props => [];
}

class GameLoadingState extends GamesState {
  const GameLoadingState();

  @override
  List<Object?> get props => [];
}

class GamesCategoryLoadedState extends GamesState {
  final GetGamesCategoryResponse response;

  const GamesCategoryLoadedState(this.response);

  @override
  List<Object?> get props => [response];
}

class GameFailureState extends GamesState {
  final String error;

  const GameFailureState(this.error);

  @override
  List<Object?> get props => [error];
}