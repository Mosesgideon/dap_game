import 'package:dap_game/common/widgets/error_widget.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/features/games/lottery/data/models/game_winner.dart';
import 'package:dap_game/features/games/lottery/presentation/widget/draw_winners_item.dart';
import 'package:flutter/material.dart';

class LotteryDrawWinners extends StatefulWidget {
  const LotteryDrawWinners({super.key, required this.winners});

  final List<GameWinner> winners;

  @override
  State<LotteryDrawWinners> createState() => _LotteryDrawWinnersState();
}

class _LotteryDrawWinnersState extends State<LotteryDrawWinners> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (widget.winners.isEmpty)
            const Expanded(
                child: Center(
              child: AppPromptWidget(
                title: 'There are no winners here',
                message: '',
              ),
            )),
          Expanded(
            child: ListView.builder(
              itemCount: widget.winners.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(bottom: 18.0.h),
                child: DrawWinnersItem(
                  winner: widget.winners[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
