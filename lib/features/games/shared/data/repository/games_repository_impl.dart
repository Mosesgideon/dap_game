import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/services/network/url_config.dart';
import 'package:dap_game/features/games/lottery/data/models/get_games_categories_models.dart';
import 'package:dap_game/features/games/shared/dormain/repository/games_repository.dart';

class GameRepositoryImpl extends GamesRepository {
  final NetworkService _networkService;

  GameRepositoryImpl(this._networkService);

  @override
  Future<GetGamesCategoryResponse> getGamesCategory() async {
    final response = await _networkService.call(
        UrlConfig.getGamesCategoryEndpoint, RequestMethod.get);

    return GetGamesCategoryResponse.fromJson(response.data);
  }

// @override
// Future<dynamic> getGames(String id) async {
//   final response = await _networkService
//       .call(UrlConfig.getGamesEndpoint, RequestMethod.get, data: {"id": id});
//
//   return response.data;
// }
//
// @override
// Future<dynamic> gameDraw(String id) async {
//   final response = await _networkService
//       .call(UrlConfig.gameDrawEndpoint, RequestMethod.post, data: {"id": id});
//
//   return response.data;
// }
}
