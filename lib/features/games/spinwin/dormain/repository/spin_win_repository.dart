
import 'package:dap_game/features/games/spinwin/data/models/play_game_response.dart';
import 'package:dap_game/features/games/spinwin/data/models/update_game_payload.dart';

abstract class SpinWinRepository {
  Future<SpinGamePlayedResponse> playGame();

  Future updateGame(UpdateGamePayload payload);
}
