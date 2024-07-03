import 'package:confetti/confetti.dart';
import 'package:dap_game/common/widgets/neumorphic_button.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpinWonDialog extends StatefulWidget {
  const SpinWonDialog({super.key, required this.amountWon});

  final int amountWon;

  @override
  State<SpinWonDialog> createState() => _SpinWonDialogState();
}

class _SpinWonDialogState extends State<SpinWonDialog> {
  late ConfettiController _controller;

  bool get gameWon => widget.amountWon > 0;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 5));
    Future.delayed(
      const Duration(
        milliseconds: 200,
      ),
      () {
        _controller.play();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        child: Container(
          decoration: BoxDecoration(
              color: Pallets.white, borderRadius: BorderRadius.circular(21)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              60.verticalSpace,
              if (gameWon)
                ConfettiWidget(
                  confettiController: _controller,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: true,
                  // blastDirection: pi, // radial value - LEFT
                  particleDrag: 0.05,
                  // apply drag to the confetti
                  emissionFrequency: 0.02,
                  // how often it should emit
                  numberOfParticles: 15,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                  ],
                ),
              TextView(
                text: gameWon ? 'Congratulations 🎉' : "Oops! 🤦‍♂️",
                style: GoogleFonts.fraunces(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              20.verticalSpace,
              TextView(
                text:
                    gameWon ? 'You won ${widget.amountWon} Coins' : "You lost",
                style: GoogleFonts.fraunces(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Pallets.primary),
              ),
              8.verticalSpace,
              TextView(
                text: 'You can do better',
                style: GoogleFonts.fraunces(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              41.verticalSpace,
              CustomNeumorphicButton(
                expanded: false,
                onTap: () {
                  context.pop();
                },
                color: Pallets.primary,
                text: 'Continue',
                // expanded: false,
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
              ),
              30.verticalSpace,
            ],
          ),
        ));
  }
}
