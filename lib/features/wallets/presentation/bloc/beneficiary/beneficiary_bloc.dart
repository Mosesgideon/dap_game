import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/wallets/data/models/beneficiary_payload.dart';
import 'package:dap_game/features/wallets/data/models/beneficiary_response.dart';
import 'package:dap_game/features/wallets/dormain/beneficiaryrepository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'beneficiary_event.dart';

part 'beneficiary_state.dart';

class BeneficiaryBloc extends Bloc<BeneficiaryEvent, BeneficiaryState> {
  final BeneficiaryRepository _repository;

  BeneficiaryBloc(this._repository) : super(BeneficiaryInitial()) {
    on<BeneficiaryEvent>((event, emit) {});
    on<AddBeneficiaryEvent>(_mapAddBeneficiaryEventToState);
    on<FetchBeneficiaryEvent>(_mapFetchBeneficiaryEventToState);
  }

  Future<FutureOr<void>> _mapAddBeneficiaryEventToState(
      AddBeneficiaryEvent event, Emitter<BeneficiaryState> emit) async {
    emit(BeneficairyLoadingState());
    try {
      var response = await _repository.addBeneficiary(event.paylod);
      emit(BeneficiarySuccessState(response));
    } catch (e, stack) {
      emit(BeneficiaryFailureState(e.toString()));
      logger.e(e.toString());
      // TODO
    }
  }

  Future<FutureOr<void>> _mapFetchBeneficiaryEventToState(
      FetchBeneficiaryEvent event, Emitter<BeneficiaryState> emit) async {
    emit(FetchBeneficairyLoadingState());
    try {
      var response = await _repository.fetchBeneficiary();
      emit(FetchBeneficiarySuccessState(response));
    } catch (e) {
      emit(FetchBeneficiaryFailureState(e.toString()));
      logger.e(e.toString());
    }
  }
}
