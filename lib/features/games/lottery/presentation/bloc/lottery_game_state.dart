part of 'lottery_game_bloc.dart';

abstract class LotteryGameState extends Equatable {
  const LotteryGameState();
}

class LotteryGameInitial extends LotteryGameState {
  @override
  List<Object> get props => [];
}

class GetCountryDrawsLoading extends LotteryGameState {
  @override
  List<Object> get props => [];
}

class GetCountryDrawsLFailed extends LotteryGameState {
  @override
  List<Object> get props => [];
}

class GetCountryGamesSuccessState extends LotteryGameState {
  final GetCountryGameDrawResponse response;

  const GetCountryGamesSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class GetLuckyNumbersDrawLoading extends LotteryGameState {
  @override
  List<Object> get props => [];
}

class GetLuckyNumbersDrawLFailed extends LotteryGameState {
  final String error;

  const GetLuckyNumbersDrawLFailed(this.error);

  @override
  List<Object> get props => [];
}

class GetLuckyNumbersDrawSuccessState extends LotteryGameState {
  final GetLuckyNumbersDrawResponse response;

  const GetLuckyNumbersDrawSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class PlayGameLoadingState extends LotteryGameState {
  @override
  List<Object> get props => [];
}

class PlayGameFailureState extends LotteryGameState {
  final String error;

  const PlayGameFailureState(this.error);

  @override
  List<Object> get props => [];
}

class PlayGameSuccessState extends LotteryGameState {
  final PlayGameResponse response;

  const PlayGameSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class GamesDetailsLoading extends LotteryGameState {
  @override
  List<Object> get props => [];
}

class GamesDetailsFailureState extends LotteryGameState {
  final String error;

  const GamesDetailsFailureState(this.error);

  @override
  List<Object> get props => [];
}

class GamesDetailsSuccessState extends LotteryGameState {
  final GameDetailResponse response;

  const GamesDetailsSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class GamesPlayedLoading extends LotteryGameState {
  @override
  List<Object> get props => [];
}

class GamesPlayedFailureState extends LotteryGameState {
  final String error;

  const GamesPlayedFailureState(this.error);

  @override
  List<Object> get props => [];
}

class GamesPlayedSuccessState extends LotteryGameState {
  final GetLotteryGamesPlayedResponse response;

  const GamesPlayedSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class GetGameDrawsLoading extends LotteryGameState {
  @override
  List<Object> get props => [];
}

class GetGameDrawsFailureState extends LotteryGameState {
  final String error;

  const GetGameDrawsFailureState(this.error);

  @override
  List<Object> get props => [];
}

class GetGameDrawsSuccessState extends LotteryGameState {
  final GameDrawsResponse response;

  const GetGameDrawsSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class GetDrawResultsLoading extends LotteryGameState {
  @override
  List<Object> get props => [];
}

class GetDrawResultsFailureState extends LotteryGameState {
  final String error;

  const GetDrawResultsFailureState(this.error);

  @override
  List<Object> get props => [];
}

class GetDrawResultsSuccessState extends LotteryGameState {
  final GetDrawResultResponse response;

  const GetDrawResultsSuccessState(this.response);

  @override
  List<Object> get props => [response];
}
