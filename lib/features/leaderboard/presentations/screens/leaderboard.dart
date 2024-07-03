import 'package:dap_game/common/widgets/action_button.dart';
import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/custom_outlined_button.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/leaderboard/data/repository_impl/leaderboad_repo_impl.dart';
import 'package:dap_game/features/leaderboard/presentations/bloc/leaderboard_bloc.dart';
import 'package:dap_game/features/leaderboard/presentations/widgets/leader_list.dart';
import 'package:dap_game/features/leaderboard/presentations/widgets/topleader.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class LeaderBoard extends StatefulWidget {
  final String gameId;

  const LeaderBoard({super.key, required this.gameId});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  final leaderbloc =
      LeaderboardBloc(LeaderBoardRepositoryImpl(NetworkService()));

  @override
  void initState() {
    leaderbloc.add(LeaderBoardFetchedEvent(widget.gameId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittle: const TextView(
          text: "LeaderBoard",
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: CustomActionButton(
          //     size: 40,
          //     child: Padding(
          //       padding: const EdgeInsets.all(10.0),
          //       child: ImageWidget(
          //         imageUrl: Assets.images.pngs.filter.path,
          //         size: 5,
          //       ),
          //     ),
          //     onTap: () {},
          //   ),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<LeaderboardBloc, LeaderboardState>(
          listener: _listenToLeadboardState,
          bloc: leaderbloc,
          builder: (context, state) {
            if (state is LeaderBoardLoadingState) {}
            if (state is LeaderBoardSuccessState) {
              if (state.response.data!.leaders!.isEmpty) {
                return Center(
                    child: CustomOutlinedButton(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  isExpanded: false,
                  radius: 20,
                  onPressed: () {
                    context.pushNamed(PageUrl.dashboard);
                  },
                  child: const TextView(
                    text: "Play Game",
                  ),
                ));
              } else {
                return Column(
                  children: [
                    15.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextView(
                                text: "Leader Board",
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Pallets.primary,
                              ),
                              6.horizontalSpace,
                              ImageWidget(
                                imageUrl: Assets.images.pngs.crown.path,
                                size: 20,
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextView(
                                text: "Top 10 Winners",
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Pallets.primary,
                              ),
                              6.horizontalSpace,
                              const TextView(
                                text: "(March)",
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Pallets.red,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    20.verticalSpace,
                    Container(
                        height: 190,
                        width: 1.sw,
                        padding: const EdgeInsets.all(20),
                        decoration:
                            BoxDecoration(color: Pallets.red.withOpacity(0.8)),
                        child: TopLeaders(
                            leaders: state.response.data!.leaders ?? [])),
                    24.verticalSpace,
                    LeaderList(leaders: state.response.data!.leaders ?? []),
                  ],
                );
              }
            }
            if (state is LeaderBoardFailureState) {

              CustomDialogs.error(state.error);

            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  void _listenToLeadboardState(BuildContext context, LeaderboardState state) {
    if (state is LeaderBoardLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is LeaderBoardSuccessState) {
      context.pop();
    }
    if (state is LeaderBoardFailureState) {
      context.pop();
      CustomDialogs.success(state.error);
    }
  }
}
