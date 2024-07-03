part of 'bank_bloc.dart';

@immutable
abstract class BankState extends Equatable {}

class BankInitial extends BankState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FetchBankLoadingState extends BankState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class BanksUpdated extends BankState {
  var uid = const Uuid().v1();
  @override
  List<Object?> get props => [uid];
}

class FetchBankSuccessState extends BankState {
  FetchBankResponse response;

  FetchBankSuccessState(this.response);

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}

class FetchBankFailiureState extends BankState {
  String error;

  FetchBankFailiureState(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class VerifyBankLoadingState extends BankState {
  @override
  List<Object?> get props => [];
}

class VerifyBankSuccessState extends BankState {
  VerifyBankAccountResponse response;

  VerifyBankSuccessState(this.response);

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}

class VerifyBankFailureState extends BankState {
  String error;

  VerifyBankFailureState(this.error);

  @override
  List<Object?> get props => [error];
}
