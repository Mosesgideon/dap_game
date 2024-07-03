import 'package:dap_game/features/games/lottery/data/models/get_games_categories_models.dart';

abstract class GamesRepository {

  Future<GetGamesCategoryResponse> getGamesCategory();

  // Future<dynamic> getGames(String id);
  //
  // Future<dynamic> gameDraw(String id);
// Future<GetGamesCategoryResponse> gameDraw(String id);

}
