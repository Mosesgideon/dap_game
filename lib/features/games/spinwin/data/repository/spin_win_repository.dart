import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/services/network/url_config.dart';
import 'package:dap_game/features/games/lottery/data/models/play_game_response.dart';
import 'package:dap_game/features/games/spinwin/data/models/play_game_response.dart';
import 'package:dap_game/features/games/spinwin/data/models/update_game_payload.dart';
import 'package:dap_game/features/games/spinwin/dormain/repository/spin_win_repository.dart';

class SpinWinRepositoryImpl extends SpinWinRepository {
  final NetworkService _networkService;

  SpinWinRepositoryImpl(this._networkService);

  @override
  Future<SpinGamePlayedResponse> playGame() async {
    try {
      final response = await _networkService.call(
        UrlConfig.playSpinGame,
        RequestMethod.post,
      );
      return SpinGamePlayedResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future updateGame(UpdateGamePayload payload) async {
    try {
      final response = await _networkService.call(
          UrlConfig.updateSpinGame, RequestMethod.post,
          data: payload.toJson());
      return response.data;
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      rethrow;
    }
  }
}
