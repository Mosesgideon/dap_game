import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:dap_game/features/wallets/data/models/make_withdrawal_response.dart';
import 'package:dap_game/features/wallets/data/models/wallet_details_response.dart';
import 'package:dap_game/features/wallets/dormain/wallet_repository.dart';
import 'package:equatable/equatable.dart';

part 'wallet_event.dart';

part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository _walletRepository;

  WalletBloc(this._walletRepository) : super(WalletInitial()) {
    on<WalletEvent>((event, emit) {});
    on<GetWalletDetailsEvent>(_mapGetWalletDetailsEventToState);
    on<RequestWithdrawalEvent>(_mapRequestWithdrawalEventToState);
    on<SwapCoinEvent>(_mapSwapCoinEventToState);
  }

  var balance = '0';

  FutureOr<void> _mapGetWalletDetailsEventToState(
      GetWalletDetailsEvent event, Emitter<WalletState> emit) async {
    try {
      emit(GetWalletLoadingState());
      final response = await _walletRepository.getWalletDetails();
      balance = response.data.wallet.balance;
      emit(GetWalletSuccessState(response));
    } catch (e) {
      emit(GetWalletFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapRequestWithdrawalEventToState(
      RequestWithdrawalEvent event, Emitter<WalletState> emit) async {
    try {
      emit(RequestWithdrawLoadingState());
      final response = await _walletRepository.requestWithdrawal(
          amount: event.amount, beneficiaryId: event.beneficiaryId);
      // balance = response.data.wallet.balance;
      emit(RequestWithdrawSuccessState(response));
    } catch (e) {
      emit(RequestWithdrawFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapSwapCoinEventToState(
      SwapCoinEvent event, Emitter<WalletState> emit) async {
    try {
      emit(SwapCoinLoadingState());
      final response = await _walletRepository.swap(
          amount: event.amount, swapType: event.swapType);
      // balance = response.data.wallet.balance;
      injector.get<ProfileBloc>().add(GetProfileEvent());
      emit(SwapCoinSuccessState(response));
    } catch (e) {
      emit(SwapCoinFailureState(e.toString()));
    }
  }
}
