import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/core/utils/extensions/context_extension.dart';
import 'package:dap_game/features/games/lottery/data/models/game_details_response.dart';
import 'package:flutter/material.dart';

class LotterySelectionItem extends StatelessWidget {
  const LotterySelectionItem({super.key, required this.gamePlayed});

  final GamesPlayed gamePlayed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: context.colorScheme.surface.withOpacity(0.5)),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 5.w,
              decoration: BoxDecoration(
                color: _getBackgroundColor(gamePlayed.status.toUpperCase()),
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextView(
                            text: gamePlayed.selection,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                          if (gamePlayed.status == 'WON') 6.verticalSpace,
                          if (gamePlayed.status.toUpperCase() == 'WON')
                            TextView(
                              text: 'Amount : \$${gamePlayed.amountWon}',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          backgroundColor: _getBackgroundColor(
                              gamePlayed.status.toUpperCase()),
                          shape: const StadiumBorder(),
                          foregroundColor: Pallets.white),
                      child: TextView(
                        text: gamePlayed.status.toUpperCase(),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    // 10.horizontalSpace
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _getBackgroundColor(String status) {
  switch (status) {
    case 'ACTIVE':
      return Pallets.primary;
    case 'WON':
      return Pallets.successGreen;
    case 'LOST':
      return Colors.red;
    default:
      return Colors.red;
  }
}
