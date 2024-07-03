part of 'faq_bloc.dart';

@immutable
abstract class FaqState extends Equatable {}

class FaqInitial extends FaqState {
  @override
  List<Object?> get props => [];
}
class FaqLoadingState extends FaqState {
  @override
  List<Object?> get props =>[];
}
class FaqFetchedState extends FaqState {
 final FaqResponse response;

  FaqFetchedState(this.response);

  @override
  List<Object?> get props => [response];
}

class FaqFetchFailureState extends FaqState {
  String error;

  FaqFetchFailureState(this.error);

  @override
  List<Object?> get props => [error];
}
