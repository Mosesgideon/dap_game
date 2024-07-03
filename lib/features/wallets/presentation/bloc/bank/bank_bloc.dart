import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/wallets/data/models/fetch_bank_response.dart';
import 'package:dap_game/features/wallets/data/models/verify_bank_response.dart';
import 'package:dap_game/features/wallets/dormain/fetch_bank_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'bank_event.dart';

part 'bank_state.dart';

class BankBloc extends Bloc<BankEvent, BankState> {
  final BankRepository _repository;
  List<BankData> banks = [];

  BankBloc(this._repository) : super(BankInitial()) {
    on<BankEvent>((event, emit) {});
    on<FetchBankEvent>(_mapFetchBankEventToState);
    on<VerifyBankEvent>(_mapVerifyBankEventToState);
  }

  Future<FutureOr<void>> _mapFetchBankEventToState(
      FetchBankEvent event, Emitter<BankState> emit) async {
    try {
      if (true) {
        emit(FetchBankLoadingState());

        var response = await _repository.selectBank(event.countryCode);
        banks = response.data;
        emit(FetchBankSuccessState(response));
      } else {
        emit(BanksUpdated());
      }
    } catch (e, stack) {
      emit(FetchBankFailiureState(e.toString()));
      logger.e(e.toString(), stackTrace: stack);
    }
  }

  FutureOr<void> _mapVerifyBankEventToState(
      VerifyBankEvent event, Emitter<BankState> emit) async {
    emit(VerifyBankLoadingState());
    try {
      var response = await _repository.verifyBankAccount(
          event.accountNumber, event.bankCode);

      emit(VerifyBankSuccessState(response));
    } catch (e) {
      emit(VerifyBankFailureState(e.toString()));
      logger.e(e.toString());
    }
  }
}
