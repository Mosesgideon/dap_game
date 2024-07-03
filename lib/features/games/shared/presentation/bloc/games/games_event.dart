part of 'games_bloc.dart';

abstract class GamesEvent extends Equatable {
  const GamesEvent();
}


class GetGamesCategoryEvent extends GamesEvent {
  const GetGamesCategoryEvent();

  @override
  List<Object?> get props => [];
}