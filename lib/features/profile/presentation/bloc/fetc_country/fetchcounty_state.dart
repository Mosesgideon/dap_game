part of 'fetchcounty_bloc.dart';

@immutable
abstract class FetchcountyState extends Equatable {}

class FetchcountyInitial extends FetchcountyState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FetchCountryLoadingState extends FetchcountyState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FetchCountrySuccessState extends FetchcountyState {
  FetchCountriesResponse response;

  FetchCountrySuccessState(this.response);

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}

class FetchCountryFailureState extends FetchcountyState {
  String error;

  FetchCountryFailureState(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
