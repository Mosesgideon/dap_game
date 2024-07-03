import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/profile/data/models/fectcountryResponse.dart';
import 'package:dap_game/features/profile/domain/repository/account_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'fetchcounty_event.dart';

part 'fetchcounty_state.dart';

class FetchcountyBloc extends Bloc<FetchcountyEvent, FetchcountyState> {
  final AccountRepository _repository;

  FetchcountyBloc(this._repository) : super(FetchcountyInitial()) {
    on<FetchcountyEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CountryFectchedEvent>(_mapCountryFetchedEventToState);
  }

  Future<FutureOr<void>> _mapCountryFetchedEventToState(
      CountryFectchedEvent event, Emitter<FetchcountyState> emit) async {
    emit(FetchCountryLoadingState());

    try {
      var response = await _repository.fetchCountry();
      emit(FetchCountrySuccessState(response));
    } catch (e) {
      logger.e(e.toString());
    }
  }
}
