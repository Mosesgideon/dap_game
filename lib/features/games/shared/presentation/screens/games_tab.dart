import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/error_widget.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/games/shared/presentation/bloc/games/games_bloc.dart';
import 'package:dap_game/features/games/shared/presentation/widgets/game_category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamesTab extends StatefulWidget {
  const GamesTab({super.key});

  @override
  State<GamesTab> createState() => _GamesTabState();
}

class _GamesTabState extends State<GamesTab> {
  final _gameBloc = GamesBloc(injector.get());

  @override
  void initState() {
    _gameBloc.add(const GetGamesCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
          leading: 0.verticalSpace,
          tittleText: 'All Games'),
      body: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            Expanded(
                child: BlocConsumer<GamesBloc, GamesState>(
              bloc: _gameBloc,
              listener: _listenToGamesStates,
              builder: (context, state) {
                if (state is GameLoadingState) {
                  return SizedBox(
                    height: 400.h,
                    child: Center(
                      child: CustomDialogs.getLoading(size: 30),
                    ),
                  );
                }

                if (state is GamesCategoryLoadedState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.response.data.games.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: GameCategoryItem(
                        category: state.response.data.games[index],
                      ),
                    ),
                  );
                }

                if (state is GameFailureState) {
                  return Center(
                    child: AppPromptWidget(
                      onTap: () {
                        _gameBloc.add(const GetGamesCategoryEvent());
                      },
                    ),
                  );
                }

                return 0.verticalSpace;
              },
            ))
          ],
        ),
      ),
    );
  }

  void _listenToGamesStates(BuildContext context, GamesState state) {}
}
