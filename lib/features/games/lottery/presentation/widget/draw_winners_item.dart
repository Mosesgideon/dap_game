import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/_core.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/games/lottery/data/models/game_winner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawWinnersItem extends StatelessWidget {
  const DrawWinnersItem({super.key, required this.winner});

  final GameWinner winner;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImageWidget(
              imageUrl: winner.image,
              size: 50,
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: winner.username,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  4.verticalSpace,
                  TextView(
                    text: TimeUtil.formatDateWithTime(
                        winner.timePlayed!.toIso8601String()),
                    fontSize: 12,
                  ),
                ],
              ),
            ),
            TextView(
              text: "${winner.amount.formatAmount()}",
              style: GoogleFonts.sora(
                  fontSize: 14.sp,
                  color: Pallets.primary,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        4.verticalSpace,
        // TextView(text: 'Selections'),
        Wrap(
          spacing: 3,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.start,
          direction: Axis.horizontal,
          children: List.generate(
              winner.selection.length,
              (index) => Chip(
                    label: TextView(
                      text: winner.selection[index],
                      fontSize: 15,
                    ),
                  )),
        )
      ],
    );
  }
}
