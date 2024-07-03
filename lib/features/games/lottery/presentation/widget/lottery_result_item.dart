import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/core/utils/extensions/context_extension.dart';
import 'package:dap_game/features/games/lottery/data/models/game_result_response.dart';
import 'package:flutter/material.dart';

class LotteryResultItem extends StatelessWidget {
  const LotteryResultItem({super.key, required this.result});

  final ResultElement result;

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
              decoration: const BoxDecoration(color: Pallets.successGreen),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text: result.selection,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                    6.verticalSpace,
                    TextView(
                      text: '\$${result.amount}',
                      fontSize: 16,
                      color: Pallets.primary,
                      fontWeight: FontWeight.w600,
                    ),
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
      return Pallets.primary;
  }
}
