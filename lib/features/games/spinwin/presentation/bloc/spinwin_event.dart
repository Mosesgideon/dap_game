part of 'spinwin_bloc.dart';

abstract class SpinwinEvent extends Equatable {
  const SpinwinEvent();
}

class PlayGameEvent extends SpinwinEvent {
  @override
  List<Object?> get props => [];
}

class UpdateGameEvent extends SpinwinEvent {
  final UpdateGamePayload payload;

  const UpdateGameEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}
