import 'dart:convert';
import 'package:dap_game/common/widgets/neumorphic_button.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/navigation/path_params.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/games/lottery/data/models/get_games_categories_models.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameItem extends StatelessWidget {
  const GameItem({super.key, required this.game});

  final DapGame game;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 170,
          width: 1.sw,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(game.posterImg), fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
              color: Pallets.primary.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: CustomNeumorphicButton(
                onTap: () {
                  logger.i(game.id.toString());
                  context.pushNamed(game.path, queryParameters: {
                    PathParam.id: game.id.toString(),
                    PathParam.game: jsonEncode(game.toJson())
                  });

                  // context.pushNamed(PageUrl.countryGame);
                },
                color: Pallets.secondaryLight,
                expanded: false,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
                child: TextView(
                  text: 'Play now',
                  style: GoogleFonts.sora(
                      fontSize: 16,
                      color: Pallets.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
        10.verticalSpace,
        // const TextView(
        //   text: 'Numbers Game',
        //   fontSize: 18,
        //   fontWeight: FontWeight.w600,
        // )
      ],
    );
  }
}
