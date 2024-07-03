import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/services/network/url_config.dart';
import 'package:dap_game/features/games/lottery/data/models/game_details_response.dart';
import 'package:dap_game/features/games/lottery/data/models/game_draws_response.dart';
import 'package:dap_game/features/games/lottery/data/models/game_result_response.dart';
import 'package:dap_game/features/games/lottery/data/models/get_country_game_draw_response.dart';
import 'package:dap_game/features/games/lottery/data/models/get_lucky_numbers_draw_response.dart';
import 'package:dap_game/features/games/lottery/data/models/get_number_games_played.dart';
import 'package:dap_game/features/games/lottery/data/models/play_game_payload.dart';
import 'package:dap_game/features/games/lottery/data/models/play_game_response.dart';
import 'package:dap_game/features/games/lottery/dormain/repository/lottery_game_repository.dart';

class LotteryGameRepositoryImpl extends LotteryGameRepository {
  final NetworkService _networkService;

  LotteryGameRepositoryImpl(this._networkService);

  @override
  Future<dynamic> getGames(String id) async {
    final response = await _networkService
        .call(UrlConfig.getGamesEndpoint, RequestMethod.get, data: {"id": id});
    return response.data;
  }

  @override
  Future<GetLuckyNumbersDrawResponse> getNumberDraw(String id) async {
    try {
      final response = await _networkService.call(
          UrlConfig.gameDrawEndpoint, RequestMethod.get,
          queryParams: {"game_id": id});
      return GetLuckyNumbersDrawResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetCountryGameDrawResponse> getCountryDraw(String id) async {
    try {
      final response = await _networkService.call(
          UrlConfig.gameDrawEndpoint, RequestMethod.get,
          queryParams: {"game_id": id});

      return GetCountryGameDrawResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PlayGameResponse> playCountryGame(PlayGamePayload payload) async {
    try {
      final response = await _networkService.call(
          UrlConfig.playNumberGame, RequestMethod.post,
          data: payload.toJson());

      return PlayGameResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GameDetailResponse> getGameDetails(String gamePlayedId) async {
    try {
      final response = await _networkService.call(
          UrlConfig.gameDetails, RequestMethod.post,
          data: {"played_game_id": gamePlayedId});

      return GameDetailResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetLotteryGamesPlayedResponse> getNumbersGamePlayed(
      String gamePlayedId) async {
    try {
      final response = await _networkService.call(
          UrlConfig.gamesPlayed, RequestMethod.post,
          data: {"game_id": gamePlayedId});

      return GetLotteryGamesPlayedResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetDrawResultResponse> getDrawResult(String drawId) async {
    try {
      final response = await _networkService.call(
          UrlConfig.drawResults, RequestMethod.post,
          data: {"draw_id": drawId});

      return GetDrawResultResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.i(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<GameDrawsResponse> getGameDraws(String gameId) async {
    try {
      final response = await _networkService.call(
          UrlConfig.gameDraws, RequestMethod.post,
          data: {"game_id": gameId});

      return GameDrawsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
