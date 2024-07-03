import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/path_params.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/games/lottery/data/models/get_number_games_played.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LotteryPlayedGameItem extends StatelessWidget {
  const LotteryPlayedGameItem(
      {super.key, required this.game, required this.gameName});

  final LotteryGame game;
  final String gameName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(PageUrl.lotteryGameDetails,
            queryParameters: {PathParam.id: game.id.toString()});
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Pallets.buttonGrey, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            // CustomActionButton(
            //   gradient: const LinearGradient(colors: [
            //     Pallets.secondary,
            //     Pallets.secondary,
            //     Pallets.secondary2,
            //   ]),
            //   size: 45,
            //   child: Center(
            //     child: TextView(
            //       text: '341',
            //       style: GoogleFonts.sora(
            //         fontSize: 22.sp,
            //         color: Pallets.white,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            //   onTap: () {},
            // ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                      text: gameName,
                      style: GoogleFonts.sora(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Pallets.primary)),
                  5.verticalSpace,
                  TextView(text: 'Total stake: \$${game.amountStaked}'),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  backgroundColor: _getBackgroundColor(game),
                  shape: const StadiumBorder(),
                  foregroundColor: Pallets.white),
              child: TextView(
                text: game.status.toUpperCase(),
                fontWeight: FontWeight.w600,
              ),
            )
            // Container(decoration: BoxDecoration(),)
            // ImageWidget(imageUrl: Assets.images.svgs.delete)
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor(LotteryGame game) {
    switch (game.status) {
      case 'ACTIVE':
        return Pallets.primary;
      case 'WON':
        return Colors.green;
      case 'LOST':
        return Colors.red;
      default:
        return Pallets.primary;
    }
  }
}
