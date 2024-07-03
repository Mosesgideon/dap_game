part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();
}

class WalletInitial extends WalletState {
  @override
  List<Object> get props => [];
}

class GetWalletLoadingState extends WalletState {
  @override
  List<Object> get props => [];
}

class GetWalletFailureState extends WalletState {
  final String error;

  const GetWalletFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class GetWalletSuccessState extends WalletState {
  final WalletDetailsResponse response;

  const GetWalletSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class RequestWithdrawLoadingState extends WalletState {
  @override
  List<Object> get props => [];
}

class RequestWithdrawFailureState extends WalletState {
  final String error;

  const RequestWithdrawFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class RequestWithdrawSuccessState extends WalletState {
  final MakeWithdrawalResponse response;

  const RequestWithdrawSuccessState(this.response);

  @override
  List<Object> get props => [response];
}


class SwapCoinLoadingState extends WalletState {
  @override
  List<Object> get props => [];
}

class SwapCoinFailureState extends WalletState {
  final String error;

  const SwapCoinFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class SwapCoinSuccessState extends WalletState {
  final dynamic response;

  const SwapCoinSuccessState(this.response);

  @override
  List<Object> get props => [response];
}
