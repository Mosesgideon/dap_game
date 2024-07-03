import 'package:dap_game/features/games/lottery/data/models/game_result_response.dart';
import 'package:dap_game/features/games/lottery/presentation/widget/lottery_result_item.dart';
import 'package:flutter/material.dart';

class LotteryDrawResults extends StatefulWidget {
  const LotteryDrawResults({super.key, required this.results});

  final List<ResultElement> results;

  @override
  State<LotteryDrawResults> createState() => _LotteryDrawResultsState();
}

class _LotteryDrawResultsState extends State<LotteryDrawResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.results.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: LotteryResultItem(
            result: widget.results[index],
          ),
        ),
      ),
    );
  }
}
