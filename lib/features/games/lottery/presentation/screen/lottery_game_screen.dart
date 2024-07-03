import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class LotteryGameScreen extends StatefulWidget {
  const LotteryGameScreen({super.key, required this.gameId});

  final String gameId;

  @override
  State<LotteryGameScreen> createState() => _LotteryGameScreenState();
}

class _LotteryGameScreenState extends State<LotteryGameScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(tittleText: 'Lottery Game'),
      body: Padding(
        padding: EdgeInsets.all(17),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
