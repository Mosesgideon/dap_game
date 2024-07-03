import 'dart:convert';

import 'package:dap_game/common/widgets/neumorphic_button.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/path_params.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/core/utils/_utils.dart';
import 'package:dap_game/features/games/lottery/data/models/get_games_categories_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameCategoryItem extends StatelessWidget {
  const GameCategoryItem({super.key, required this.category});

  final GameCategory category;

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
                  image: NetworkImage(category.posterImg), fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
              color: Pallets.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextView(
                    text: category.category.toUpperCase(),
                    style: GoogleFonts.alike(
                        fontSize: 18,
                        color: Pallets.white,
                        fontWeight: FontWeight.w600),
                  ),
                  10.verticalSpace,
                  CustomNeumorphicButton(
                    onTap: () {
                      if (category.type.toLowerCase() == "single") {
                        context.pushNamed(category.path, queryParameters: {
                          PathParam.id: category.games.first.id.toString(),
                          PathParam.game:
                              jsonEncode(category.games.first.toJson())
                        });
                      } else {
                        context.pushNamed(PageUrl.categoryGames,
                            queryParameters: {
                              PathParam.category: jsonEncode(category.toJson())
                            });
                      }

                      // context.pushNamed(PageUrl.spiningWheel);
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
                ],
              ),
            ),
          ),
        ),
        8.verticalSpace,
        // TextView(
        //   text: category.category.toUpperCase(),
        //   fontSize: 18,
        //   fontWeight: FontWeight.w600,
        // ),
        // 16.verticalSpace,
      ],
    );
  }
}
