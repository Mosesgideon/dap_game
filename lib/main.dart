import 'package:dap_game/app_config.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/services/network/url_config.dart';
import 'package:dap_game/features/authentiction/data/repository/authrepository_impl.dart';

void main() {
  AppConfig.initializeAndRunInstance(
      appName: 'Dap Game', enviroment: Environment.development);

  //
  // var ap = AuthRepositoryImpl(injector.get());
  //
  // ap.authenticateWithApple();
}
