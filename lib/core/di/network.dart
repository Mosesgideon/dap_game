import 'package:get_it/get_it.dart';
import 'package:dap_game/core/services/network/network_service.dart';

void setup(GetIt getIt) {
  // getIt.allowReassignment = true;
  // getIt.allowReassignment = true;
  getIt.registerLazySingleton<NetworkService>(() => NetworkService());
}
