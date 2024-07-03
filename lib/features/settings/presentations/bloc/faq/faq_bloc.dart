import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/settings/data/models/faq_response.dart';
import 'package:dap_game/features/settings/domain/repository/faq_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'faq_event.dart';

part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  final FaqRepository _repository;

  FaqBloc(this._repository) : super(FaqInitial()) {
    on<FaqEvent>((event, emit) {});
    on<FaqFetchedEvent>(_mapFaqFetchedEventToState);
  }

  Future<FutureOr<void>> _mapFaqFetchedEventToState(
      FaqFetchedEvent event, Emitter<FaqState> emit) async {
    try {
      emit(FaqLoadingState());
      var reponse = await _repository.faq();
      emit(FaqFetchedState(reponse));
    } catch (e, stack) {
      logger.e(e.toString());
      logger.i(e.toString());
    }
  }
}
