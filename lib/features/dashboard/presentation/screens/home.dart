import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/error_widget.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/dashboard/dormain/usecase/dashboard_usecase.dart';
import 'package:dap_game/features/dashboard/presentation/widgets/home_appbar.dart';
import 'package:dap_game/features/games/shared/presentation/bloc/games/games_bloc.dart';
import 'package:dap_game/features/games/shared/presentation/widgets/game_category_item.dart';
import 'package:dap_game/features/leaderboard/presentations/screens/leaderboard.dart';
import 'package:dap_game/features/results/presentation/widgets/home_result_card.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _gameBloc = GamesBloc(injector.get());

  @override
  void initState() {
    super.initState();
    DashboardUsecase().execute();
    _gameBloc.add(const GetGamesCategoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Pallets.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              // 20.verticalSpace,
              const HomeApBar(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    _gameBloc.add(const GetGamesCategoryEvent());
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.verticalSpace,
                        const HomeResultCard(),
                        25.verticalSpace,
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     TextView(
                        //       text: 'Featured Games',
                        //       color: Pallets.primary,
                        //       fontSize: 22.sp,
                        //       fontWeight: FontWeight.w700,
                        //       // style: GoogleFonts.sora(),
                        //     ),
                        //     const TextView(
                        //       text: 'View all',
                        //       color: Pallets.primary,
                        //
                        //       fontWeight: FontWeight.w600,
                        //       // style: GoogleFonts.sora(),
                        //     ),
                        //   ],
                        // ),
                        // 18.verticalSpace,
                        // const GameItem(),
                        // 18.verticalSpace,
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ImageWidget(imageUrl: Assets.images.svgs.game),
                            5.horizontalSpace,
                            TextView(
                              text: 'All Games',
                              style: GoogleFonts.poppins(
                                color: Pallets.primary,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            // const TextView(
                            //   text: 'View all',
                            //   color: Pallets.primary,
                            //
                            //   fontWeight: FontWeight.w600,
                            //   // style: GoogleFonts.sora(),
                            // ),
                          ],
                        ),
                        16.verticalSpace,
                        BlocConsumer<GamesBloc, GamesState>(
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
                                  padding: const EdgeInsets.only(bottom: 10.0),
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
                                    _gameBloc
                                        .add(const GetGamesCategoryEvent());
                                  },
                                ),
                              );
                            }

                            return 0.verticalSpace;
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _listenToGamesStates(BuildContext context, GamesState state) {}
}
