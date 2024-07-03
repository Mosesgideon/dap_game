import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/error_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/_core.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/core/utils/extensions/context_extension.dart';
import 'package:dap_game/core/utils/string_extension.dart';
import 'package:dap_game/features/games/lottery/data/models/game_details_response.dart';
import 'package:dap_game/features/games/lottery/presentation/bloc/lottery_game_bloc.dart';
import 'package:dap_game/features/games/lottery/presentation/widget/draw_result_sheet.dart';
import 'package:dap_game/features/games/lottery/presentation/widget/lottery_selection_item.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class GamesDetailsScreen extends StatefulWidget {
  const GamesDetailsScreen({super.key, required this.gameId});

  final String gameId;

  @override
  State<GamesDetailsScreen> createState() => _GamesDetailsScreenState();
}

class _GamesDetailsScreenState extends State<GamesDetailsScreen> {
  final _bloc = LotteryGameBloc(injector.get());

  @override
  void initState() {
    _bloc.add(GetGamesDetailsEvent(widget.gameId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        tittleText: 'Game Details',
      ),
      body: BlocConsumer<LotteryGameBloc, LotteryGameState>(
        bloc: _bloc,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GamesDetailsLoading) {
            return Center(
              child: CustomDialogs.getLoading(size: 30),
            );
          }

          if (state is GamesDetailsFailureState) {
            return Center(
              child: AppPromptWidget(
                onTap: () {
                  _bloc.add(GetGamesDetailsEvent(widget.gameId));
                },
              ),
            );
          }

          if (state is GamesDetailsSuccessState) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 8.verticalSpace,
                          Center(
                            child: TextView(
                              text: TimeUtil.formatDateWithTime(
                                state.response.data.playedGame.createdAt
                                    .toIso8601String(),
                              ),
                              color: Pallets.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          30.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView(
                                      text:
                                          '${double.parse(state.response.data.playedGame.potentialWin).round().toString().formatAmount()}',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24.sp,
                                      // style: GoogleFonts.sora(
                                      //
                                      // ),
                                    ),
                                    const TextView(
                                      text: 'Potential Win',
                                      fontSize: 14,
                                      color: Pallets.secondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  CustomDialogs.showBottomSheet(
                                      context,
                                      DrawResultSheet(
                                        drawId: state
                                            .response.data.playedGame.draw.id
                                            .toString(),
                                      ));
                                },
                                style: TextButton.styleFrom(
                                    // backgroundColor: _getBackgroundColor('WON'),
                                    shape: const StadiumBorder(
                                        side: BorderSide(
                                            width: 1, color: Pallets.primary)),
                                    foregroundColor: Pallets.primary),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextView(
                                    text: 'View All Winners',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          30.verticalSpace,
                          const TextView(
                            text: 'Your picks',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          16.verticalSpace,
                          ...List.generate(
                              state.response.data.playedGame.gamesPlayed.length,
                              (index) => Padding(
                                    padding: EdgeInsets.only(bottom: 16.h),
                                    child: LotterySelectionItem(
                                        gamePlayed: state.response.data
                                            .playedGame.gamesPlayed[index]),
                                  ))
                        ],
                      ),
                    ),
                  ),
                  6.verticalSpace,
                  Container(
                    decoration:
                        BoxDecoration(color: context.colorScheme.background),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const TextView(
                              text: 'Total Stake',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: DottedLine(
                                  direction: Axis.horizontal,
                                  dashLength: 5,
                                ),
                              ),
                            ),
                            TextView(
                              text:
                                  '${state.response.data.playedGame.amountStaked.formatAmount()}',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,

                              // fontWeight: ,
                            )
                          ],
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            const TextView(
                              text: 'Bonus',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: DottedLine(
                                  direction: Axis.horizontal,
                                  dashLength: 5,
                                ),
                              ),
                            ),
                            TextView(
                              text: '${state.response.data.playedGame.bonus.formatAmount()}',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,

                              // fontWeight: ,
                            )
                          ],
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            const TextView(
                              text: 'Total Wining',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: DottedLine(
                                  direction: Axis.horizontal,
                                  dashLength: 5,
                                ),
                              ),
                            ),
                            TextView(
                              text: state.response.data.playedGame.status ==
                                      'active'
                                  ? '\$--- ---'
                                  : '\$${_getTotalAmountWon(state.response.data.playedGame)}',

                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Pallets.successGreen,

                              // fontWeight: ,
                            )
                          ],
                        ),
                        50.verticalSpace
                      ],
                    ),
                  )
                ],
              ),
            );
          }

          return 0.verticalSpace;
        },
      ),
    );
  }

  Color _getBackgroundColor(String status) {
    switch (status) {
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

  _getTotalAmountWon(PlayedGame playedGame) {
    var total = 0;
    for (var game in playedGame.gamesPlayed) {
      total += game.amountWon;
    }
    return total;
  }
}
