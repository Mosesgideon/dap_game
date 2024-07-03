part of 'spinwin_bloc.dart';

abstract class SpinwinState extends Equatable {
  const SpinwinState();
}

class SpinwinInitial extends SpinwinState {
  @override
  List<Object> get props => [];
}

class PlayGameLoadingState extends SpinwinState {
  @override
  List<Object> get props => [];
}

class PlayGameFailedState extends SpinwinState {
  final String error;

  const PlayGameFailedState(this.error);

  @override
  List<Object> get props => [];
}

class PlayGameSuccessState extends SpinwinState {
  final SpinGamePlayedResponse response;

  const PlayGameSuccessState(this.response);

  @override
  List<Object> get props => [response];
}




class UpdateGameLoadingState extends SpinwinState {
  @override
  List<Object> get props => [];
}

class UpdateGameFailedState extends SpinwinState {
  final String error;

  const UpdateGameFailedState(this.error);

  @override
  List<Object> get props => [];
}

class UpdateGameSuccessState extends SpinwinState {
  final dynamic response;

  const UpdateGameSuccessState(this.response);

  @override
  List<Object> get props => [response];
}


