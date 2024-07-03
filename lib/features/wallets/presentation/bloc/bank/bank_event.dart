part of 'bank_bloc.dart';

abstract class BankEvent extends Equatable {}

class FetchBankEvent extends BankEvent {
  final String countryCode;

  FetchBankEvent(this.countryCode);

  @override
  List<Object?> get props => [countryCode];
}

class VerifyBankEvent extends BankEvent {
  final String accountNumber;
  final String bankCode;

  VerifyBankEvent(this.accountNumber, this.bankCode);

  @override
  List<Object?> get props => [accountNumber, bankCode];
}
