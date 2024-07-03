part of 'leaderboard_bloc.dart';

@immutable
abstract class LeaderboardEvent extends Equatable {}

class LeaderBoardFetchedEvent extends LeaderboardEvent {
  final String gameId;

  LeaderBoardFetchedEvent(this.gameId);

  @override
  List<Object?> get props => [gameId];
}
