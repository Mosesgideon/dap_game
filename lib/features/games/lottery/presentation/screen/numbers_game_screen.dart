import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/duration_timer.dart';
import 'package:dap_game/common/widgets/error_widget.dart';
import 'package:dap_game/common/widgets/neumorphic_button.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/navigation/path_params.dart';
import 'package:dap_game/core/services/data/session_manager.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/core/utils/string_extension.dart';
import 'package:dap_game/features/games/lottery/data/models/get_games_categories_models.dart';
import 'package:dap_game/features/games/lottery/data/models/play_game_payload.dart';
import 'package:dap_game/features/games/lottery/presentation/bloc/lottery_game_bloc.dart';
import 'package:dap_game/features/games/lottery/presentation/widget/number_game_result_banner.dart';
import 'package:dap_game/features/leaderboard/presentations/screens/leaderboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/navigation/route_url.dart';

class LuckyNumberGameScreen extends StatefulWidget {
  const LuckyNumberGameScreen(
      {super.key, required this.gameId, required this.game});

  final String gameId;
  final DapGame game;

  @override
  State<LuckyNumberGameScreen> createState() => _LuckyNumberGameScreenState();
}

class _LuckyNumberGameScreenState extends State<LuckyNumberGameScreen> {
  int? selectedNumber;
  final LotteryGameBloc _bloc = LotteryGameBloc(injector.get());
  var selectedNumbers = [];

  @override
  void initState() {
    _bloc.add(GetLuckyNumbersDrawsEvent(widget.gameId.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittleText: 'Number Game',
        actions: [
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: CustomNeumorphicButton(
              text: 'Leader Board',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LeaderBoard(
                        gameId: widget.gameId,
                      ),
                    ));
              },
              color: Pallets.primary,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            ),
          ),
          10.horizontalSpace
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<LotteryGameBloc, LotteryGameState>(
          bloc: _bloc,
          buildWhen: _buildWhen,
          listener: _listenToGameStates,
          builder: (context, state) {
            if (state is GetLuckyNumbersDrawLoading) {
              return Center(
                child: CustomDialogs.getLoading(size: 20),
              );
            }

            if (state is GetLuckyNumbersDrawLFailed) {
              return AppPromptWidget(
                onTap: () {
                  _bloc.add(GetLuckyNumbersDrawsEvent(widget.gameId));
                },
              );
            }
            if (state is GetLuckyNumbersDrawSuccessState) {
              return Padding(
                padding: const EdgeInsets.all(17),
                child: Column(
                  children: [
                    LotteryGameResultBanner(
                      gameId: widget.gameId,
                    ),
                    20.verticalSpace,
                    TimedText(
                        startTime: state.response.data.draw.startTime ??
                            DateTime.now(),
                        onEnded: () {
                          // _bloc.add(GetLuckyNumbersDrawsEvent(widget.gameId));
                        },
                        endTime:
                            state.response.data.draw.stopTime ?? DateTime.now(),
                        endText: 'Game Has Ended'),
                    8.verticalSpace,
                    TextView(
                      text: widget.game.instructions ?? '',
                      color: Pallets.primary,
                    ),
                    20.verticalSpace,
                    Expanded(
                        child: GridView.builder(
                      itemCount: state.response.data.draw.gameData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              crossAxisCount: 5),
                      itemBuilder: (context, index) => _NumberItem(
                        isSelected: selectedNumbers
                            .contains(state.response.data.draw.gameData[index]),
                        number:
                            state.response.data.draw.gameData[index].toString(),
                        onSelected: (String number) {
                          _selectNumber(
                              state.response.data.draw.gameData[index],
                              state.response.data.draw.stopTime);
                        },
                      ),
                    )),
                    10.verticalSpace,
                    Container(
                      // height: 100,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Pallets.buttonGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView(
                                      text:
                                          'Total Selection: ${selectedNumbers.length}',
                                      fontSize: 16.sp,
                                      color: Pallets.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    5.verticalSpace,
                                    TextView(
                                      text:
                                          'Potential win: ${widget.game.potentialWin.formatAmount()}',
                                      fontSize: 16.sp,
                                      color: Pallets.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              // Expanded(
                              //   child: TextView(
                              //     text: '50',
                              //     style: GoogleFonts.sora(
                              //         color: Pallets.secondary,
                              //         fontWeight: FontWeight.w600,
                              //         fontSize: 20.sp),
                              //   ),
                              // ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      shape: const StadiumBorder(
                                          side: BorderSide(
                                              color: Pallets.primary))),
                                  onPressed: () {
                                    context.pushNamed(PageUrl.myLotteryGames,
                                        queryParameters: {
                                          PathParam.id: widget.gameId,
                                          PathParam.gameName: widget.game.name,
                                        });
                                  },
                                  child: const Text('Your games'))
                            ],
                          ),
                          10.verticalSpace,
                          CustomNeumorphicButton(
                            onTap: () {
                              if (SessionManager.instance.isLoggedIn) {
                                _bloc.add(PlayGameEvent(PlayGamePayload(
                                    gameId: widget.game.id,
                                    drawId: state.response.data.draw.id,
                                    selection: selectedNumbers
                                        .map((e) => e.toString())
                                        .toList(),
                                    amount: _getPrice())));
                              } else {
                                CustomDialogs.error(
                                    'Please sign in to continue');
                              }
                            },
                            color: Pallets.primary,
                            text: "Play With  \$ ${_getPrice()}",
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return 0.horizontalSpace;
          },
        ),
      ),
    );
  }

  bool _buildWhen(LotteryGameState previous, LotteryGameState current) {
    return current is GetLuckyNumbersDrawSuccessState ||
        current is GetLuckyNumbersDrawLFailed ||
        current is GetLuckyNumbersDrawLoading;
  }

  void _selectNumber(int gameData, DateTime drawEndTime) {
    if (DateTime.now().isAfter(drawEndTime)) {
      CustomDialogs.error('Draw is ended');
    } else {
      if (selectedNumbers.contains(gameData)) {
        selectedNumbers.remove(gameData);
      } else {
        if (selectedNumbers.length <= 6) {
          selectedNumbers.add(gameData);
        } else {
          CustomDialogs.error('You can only select 7 options at a time');
        }
      }
    }

    setState(() {});
  }

  _getPrice() {
    if (selectedNumbers.isEmpty) {
      return 0;
    } else {
      return double.parse(widget.game.amountPerStake) * selectedNumbers.length;
    }
  }

  void _listenToGameStates(BuildContext context, LotteryGameState state) {
    if (state is PlayGameLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is PlayGameFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is PlayGameSuccessState) {
      context.pop();
      CustomDialogs.success('Game Booked');
      selectedNumbers = [];
      setState(() {});
      context.pushNamed(PageUrl.lotteryGameDetails, queryParameters: {
        PathParam.id: state.response.data.playedGame.id.toString()
      });
    }
  }
}

class _NumberItem extends StatefulWidget {
  const _NumberItem(
      {super.key,
      required this.isSelected,
      required this.number,
      required this.onSelected});

  final bool isSelected;
  final String number;
  final Function(String number) onSelected;

  @override
  State<_NumberItem> createState() => _NumberItemState();
}

class _NumberItemState extends State<_NumberItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onSelected(widget.number);
      },
      child: AnimatedContainer(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)),
            color: Pallets.buttonGrey,
            gradient: widget.isSelected
                ? const LinearGradient(colors: [
                    Pallets.secondary,
                    Pallets.secondary2,
                  ])
                : null),
        duration: const Duration(milliseconds: 400),
        child: Center(
          child: TextView(
            text: widget.number,
            style: GoogleFonts.sora(
              color: widget.isSelected ? Pallets.white : Pallets.primary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
