part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();
}

class GetWalletDetailsEvent extends WalletEvent {
  @override
  List<Object?> get props => [];
}



class RequestWithdrawalEvent extends WalletEvent {
  final double amount;
  final int beneficiaryId;
  const RequestWithdrawalEvent(
      {required this.amount, required this.beneficiaryId});

  @override
  List<Object?> get props => [amount,beneficiaryId];
}


class SwapCoinEvent extends WalletEvent {
  final double amount;
  final String swapType;
  const SwapCoinEvent(
      {required this.amount, required this.swapType});

  @override
  List<Object?> get props => [amount,swapType];
}