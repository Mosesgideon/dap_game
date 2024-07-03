import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/duration_timer.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/neumorphic_button.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/path_params.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/services/data/session_manager.dart';
import 'package:dap_game/core/services/network/url_config.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/games/lottery/data/models/get_country_game_draw_response.dart';
import 'package:dap_game/features/games/lottery/data/models/get_games_categories_models.dart';
import 'package:dap_game/features/games/lottery/data/models/play_game_payload.dart';
import 'package:dap_game/features/games/lottery/presentation/widget/number_game_result_banner.dart';
import 'package:dap_game/features/leaderboard/presentations/screens/leaderboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/error_widget.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/utils/string_extension.dart';
import 'package:dap_game/features/games/lottery/presentation/bloc/lottery_game_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuessCountryGameScreen extends StatefulWidget {
  const GuessCountryGameScreen(
      {super.key, required this.gameId, required this.game});

  final String gameId;
  final DapGame game;

  @override
  State<GuessCountryGameScreen> createState() => _GuessCountryGameScreenState();
}

class _GuessCountryGameScreenState extends State<GuessCountryGameScreen> {
  int? selectedNumber;
  final LotteryGameBloc _bloc = LotteryGameBloc(injector.get());
  var selectedCountries = [];

  @override
  void initState() {
    _bloc.add(GetCountryDrawsEvent(widget.game.id.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittleText: 'Country Game',
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
            if (state is GetCountryDrawsLoading) {
              return Center(
                child: CustomDialogs.getLoading(size: 20),
              );
            }

            if (state is GetCountryDrawsLFailed) {
              return AppPromptWidget(
                onTap: () {
                  _bloc.add(GetCountryDrawsEvent(widget.gameId));
                },
              );
            }
            if (state is GetCountryGamesSuccessState) {
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
                          _bloc.add(GetLuckyNumbersDrawsEvent(widget.gameId));
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
                              crossAxisCount: 4),
                      itemBuilder: (context, index) => _CountryItem(
                        isSelected: selectedCountries.contains(
                            state.response.data.draw.gameData[index].name),
                        country: state.response.data.draw.gameData[index],
                        onSelected: (GameCountry number) {
                          _select(state.response.data.draw.gameData[index].name,
                              state.response.data.draw.stopTime);
                        },
                      ),
                    )),
                    20.verticalSpace,
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
                                          'Total Selection: ${selectedCountries.length}',
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
                                    selection: selectedCountries
                                        .map((e) => e.toString())
                                        .toList(),
                                    amount: _getPrice())));
                              } else {
                                CustomDialogs.error(
                                    'Please sign in to continue');
                              }
                            },
                            color: Pallets.primary,
                            text: "Play With \$${_getPrice()}",
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
      selectedCountries = [];
      setState(() {});
      context.pushNamed(PageUrl.lotteryGameDetails, queryParameters: {
        PathParam.id: state.response.data.playedGame.id.toString()
      });
    }
  }

  void _select(String gameData, DateTime drawEndTime) {
    if (DateTime.now().isAfter(drawEndTime)) {
      CustomDialogs.error('Draw is ended');
    } else {
      if (selectedCountries.contains(gameData)) {
        selectedCountries.remove(gameData);
      } else {
        if (selectedCountries.length <= 6) {
          selectedCountries.add(gameData);
        } else {
          CustomDialogs.error('You can only select 7 options at a time');
        }
      }
    }

    setState(() {});
  }

  _getPrice() {
    if (selectedCountries.isEmpty) {
      return 0;
    } else {
      return double.parse(widget.game.amountPerStake) *
          selectedCountries.length;
    }
  }

  bool _buildWhen(LotteryGameState previous, LotteryGameState current) {
    return current is GetCountryGamesSuccessState ||
        current is GetCountryDrawsLFailed ||
        current is GetCountryDrawsLoading;
  }
}

class _CountryItem extends StatefulWidget {
  const _CountryItem(
      {super.key,
      required this.isSelected,
      required this.country,
      required this.onSelected});

  final bool isSelected;
  final GameCountry country;
  final Function(GameCountry country) onSelected;

  @override
  State<_CountryItem> createState() => _CountryItemState();
}

class _CountryItemState extends State<_CountryItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onSelected(widget.country);
      },
      child: AnimatedContainer(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Pallets.buttonGrey,
            border: widget.isSelected
                ? Border.all(color: Pallets.secondary)
                : null),
        duration: const Duration(milliseconds: 400),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageWidget(
                onTap: () {
                  widget.onSelected(widget.country);
                },
                imageUrl: UrlConfig.getFlag(widget.country.code),
                size: 40,
              ),
              8.verticalSpace,
              TextView(
                text: widget.country.name,
                maxLines: 2,
                align: TextAlign.center,
                style: GoogleFonts.sora(
                  color: Pallets.primary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
