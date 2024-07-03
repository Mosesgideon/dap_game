import 'package:dap_game/features/leaderboard/data/models/leaderboard_response.dart';

abstract class LeaderBoardRepository {
  Future<LeaderBoardResponse> leaderboard(String gameId);
}
