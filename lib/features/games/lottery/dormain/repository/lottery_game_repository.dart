import 'package:dap_game/features/games/lottery/data/models/game_details_response.dart';
import 'package:dap_game/features/games/lottery/data/models/game_draws_response.dart';
import 'package:dap_game/features/games/lottery/data/models/game_result_response.dart';
import 'package:dap_game/features/games/lottery/data/models/get_country_game_draw_response.dart';
import 'package:dap_game/features/games/lottery/data/models/get_lucky_numbers_draw_response.dart';
import 'package:dap_game/features/games/lottery/data/models/get_number_games_played.dart';
import 'package:dap_game/features/games/lottery/data/models/play_game_payload.dart';
import 'package:dap_game/features/games/lottery/data/models/play_game_response.dart';

abstract class LotteryGameRepository {
  Future<dynamic> getGames(String id);

  Future<GetLuckyNumbersDrawResponse> getNumberDraw(String id);

  Future<GetCountryGameDrawResponse> getCountryDraw(String id);

  Future<PlayGameResponse> playCountryGame(PlayGamePayload payload);

  Future<GameDetailResponse> getGameDetails(String gamePlayedId);

  Future<GetLotteryGamesPlayedResponse> getNumbersGamePlayed(
      String gamePlayedId);

  Future<GameDrawsResponse> getGameDraws(String gameId);
  Future<GetDrawResultResponse> getDrawResult(String drawId);
}
