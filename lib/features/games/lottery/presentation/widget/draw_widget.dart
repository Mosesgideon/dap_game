import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/_core.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/path_params.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/core/utils/extensions/context_extension.dart';
import 'package:dap_game/features/games/lottery/data/models/game_draws_response.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawWidget extends StatelessWidget {
  const DrawWidget({super.key, required this.draw});

  final LotteryDraw draw;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(PageUrl.lotteryGamesResult,
            queryParameters: {PathParam.id: draw.id.toString()});
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Pallets.primary,
                borderRadius: BorderRadius.circular(8),
                // gradient: const LinearGradient(colors: [
                //   Pallets.secondary,
                //   Pallets.secondary2,
                // ]),
              ),
              child: Column(
                children: [
                  TextView(
                    text: 'Draw',
                    style:
                        GoogleFonts.sora(fontSize: 12.sp, color: Pallets.white),
                  ),
                  TextView(
                    text: draw.id.toString(),
                    style: GoogleFonts.sora(
                        fontSize: 25.sp,
                        color: Pallets.white,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            10.horizontalSpace,
            Expanded(
                child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: TimeUtil.formatDateWithTime(
                          draw.startTime.toIso8601String()),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    3.verticalSpace,
                    const TextView(
                      text: 'Start time',
                      fontSize: 12,
                    ),
                  ],
                ),
                const Expanded(child: Center(child: TextView(text: '--'))),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextView(
                      text: TimeUtil.formatDateWithTime(
                          draw.stopTime.toIso8601String()),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    3.verticalSpace,
                    const TextView(
                      text: 'End time',
                      fontSize: 12,
                    ),
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
