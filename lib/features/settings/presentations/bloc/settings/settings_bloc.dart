import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/settings/domain/repository/settings_repository.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository;

  SettingsBloc(this._repository) : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ContactSupportEvent>(_mapContactSupportEventToState);
  }

  FutureOr<void> _mapContactSupportEventToState(
      ContactSupportEvent event, Emitter<SettingsState> emit) async {
    try {
      emit(ContactSupportLoadingState());
      var response =
          await _repository.contactSupport(event.subject, event.message);
      emit(ContactSupportSuccessState(response));
    } catch (e, stack) {
      logger.e(stack);
      logger.e(e.toString());
      emit(ContactSupportFailedState(e.toString()));
    }
  }
}
