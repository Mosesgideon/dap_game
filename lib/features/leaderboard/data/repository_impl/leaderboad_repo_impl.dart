import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/services/network/url_config.dart';
import 'package:dap_game/features/leaderboard/data/models/leaderboard_response.dart';
import 'package:dap_game/features/leaderboard/repository/leaderboad_repository.dart';

class LeaderBoardRepositoryImpl extends LeaderBoardRepository {
  final NetworkService _networkService;

  LeaderBoardRepositoryImpl(this._networkService);

  @override
  Future<LeaderBoardResponse> leaderboard(String gameId) async {
    var response = await _networkService.call(
        UrlConfig.leaderboard, RequestMethod.get,
        queryParams: {"game_id": gameId});

    return LeaderBoardResponse.fromJson(response.data);
  }
}
