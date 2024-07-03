part of 'leaderboard_bloc.dart';

@immutable
abstract class LeaderboardState extends Equatable {}

class LeaderboardInitial extends LeaderboardState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LeaderBoardLoadingState extends LeaderboardState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LeaderBoardSuccessState extends LeaderboardState {
  final LeaderBoardResponse response;

  LeaderBoardSuccessState(this.response);

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}

class LeaderBoardFailureState extends LeaderboardState {
  final String error;

  LeaderBoardFailureState(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
