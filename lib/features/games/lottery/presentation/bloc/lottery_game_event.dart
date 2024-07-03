part of 'lottery_game_bloc.dart';

abstract class LotteryGameEvent extends Equatable {
  const LotteryGameEvent();
}

class GetCountryDrawsEvent extends LotteryGameEvent {
  final String id;

  const GetCountryDrawsEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetLuckyNumbersDrawsEvent extends LotteryGameEvent {
  final String id;

  const GetLuckyNumbersDrawsEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class PlayGameEvent extends LotteryGameEvent {
  final PlayGamePayload payload;

  const PlayGameEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}

class GetGamesPlayedEvent extends LotteryGameEvent {
  final String gameId;

  const GetGamesPlayedEvent(this.gameId);

  @override
  List<Object?> get props => [gameId];
}

class GetGamesDetailsEvent extends LotteryGameEvent {
  final String gameId;

  const GetGamesDetailsEvent(this.gameId);

  @override
  List<Object?> get props => [gameId];
}


class GetDrawResultEvent extends LotteryGameEvent {
  final String drawId;

  const GetDrawResultEvent(this.drawId);

  @override
  List<Object?> get props => [drawId];
}
class GetGameDrawsEvent extends LotteryGameEvent {
  final String gameId;

  const GetGameDrawsEvent(this.gameId);

  @override
  List<Object?> get props => [gameId];
}
