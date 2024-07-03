import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/features/games/lottery/data/models/get_games_categories_models.dart';
import 'package:dap_game/features/games/shared/presentation/widgets/game_item.dart';
import 'package:flutter/material.dart';

class CategoryGamesScreen extends StatefulWidget {
  const CategoryGamesScreen({
    super.key,
    required this.category,
  });

  final GameCategory category;

  @override
  State<CategoryGamesScreen> createState() => _CategoryGamesScreenState();
}

class _CategoryGamesScreenState extends State<CategoryGamesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittleText: '${widget.category.category} Games',
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: widget.category.games.length,
              itemBuilder: (context, index) =>
                  GameItem(game: widget.category.games[index]),
            ))
          ],
        ),
      ),
    );
  }
}
