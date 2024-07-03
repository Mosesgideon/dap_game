import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/error_widget.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/games/lottery/presentation/bloc/lottery_game_bloc.dart';
import 'package:dap_game/features/games/lottery/presentation/widget/lottery_played_game_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectionsScreen extends StatefulWidget {
  const SelectionsScreen(
      {super.key, required this.gameName, required this.gameId});

  final String gameName;
  final String gameId;

  @override
  State<SelectionsScreen> createState() => _SelectionsScreenState();
}

class _SelectionsScreenState extends State<SelectionsScreen> {
  final _bloc = LotteryGameBloc(injector.get());

  @override
  void initState() {
    _bloc.add(GetGamesPlayedEvent(widget.gameId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        tittleText: 'My Games',
        actions: [
          // TextButton(
          //     onPressed: () {}, child: const TextView(text: 'Clear all')),
          // 10.horizontalSpace
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: BlocConsumer<LotteryGameBloc, LotteryGameState>(
          bloc: _bloc,
          listener: _listenToLotteryGameBloc,
          builder: (context, state) {
            if (state is GamesPlayedLoading) {
              return Column(
                children: [
                  Expanded(
                      child: Center(
                    child: CustomDialogs.getLoading(size: 30),
                  )),
                ],
              );
            }

            if (state is GamesPlayedFailureState) {
              return Column(
                children: [
                  Expanded(
                      child: Center(
                    child: AppPromptWidget(
                      message: state.error,
                      onTap: () {
                        _bloc.add(GetGamesPlayedEvent(widget.gameId));
                      },
                    ),
                  )),
                ],
              );
            }

            if (state is GamesPlayedSuccessState) {
              if (state.response.data.games.data.isEmpty) {
                return  AppPromptWidget(
                  title: 'You have no game history',
                  message: 'Refresh to get latest updates',
                  onTap: () {
                    _bloc.add(GetGamesPlayedEvent(widget.gameId));

                  },
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.response.data.games.data.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: LotteryPlayedGameItem(
                          game: state.response.data.games.data[index],
                          gameName: widget.gameName,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }

            return 0.verticalSpace;
          },
        ),
      ),
    );
  }

  void _listenToLotteryGameBloc(BuildContext context, LotteryGameState state) {}
}
