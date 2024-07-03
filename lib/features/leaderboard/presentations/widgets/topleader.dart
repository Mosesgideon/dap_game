import 'package:dap_game/common/widgets/action_button.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/features/leaderboard/data/models/leaderboard_response.dart';
import 'package:dap_game/features/leaderboard/data/repository_impl/leaderboad_repo_impl.dart';
import 'package:dap_game/features/leaderboard/presentations/bloc/leaderboard_bloc.dart';
import 'package:flutter/material.dart';

class TopLeaders extends StatefulWidget {
  final List<Leaders> leaders;

  const TopLeaders({Key? key, required this.leaders}) : super(key: key);

  @override
  State<TopLeaders> createState() => _TopLeadersState();
}

class _TopLeadersState extends State<TopLeaders> {
  final leaderbloc =
      LeaderboardBloc(LeaderBoardRepositoryImpl(NetworkService()));

  @override
  void initState() {
    // leaderbloc.add(LeaderBoardFetchedEvent());
    super.initState();
  }

  @override
  void dispose() {
    // leaderbloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.leaders.any((leader) => leader == null || leader.user == null)) {
      return SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        LeaderWidget(
          imageRadius: 34,
          topLeader: widget.leaders[1],
          rank: 2,
        ),
        LeaderWidget(
          imageRadius: 45,
          topLeader: widget.leaders[2],
          rank: 1,
        ),
        LeaderWidget(
          imageRadius: 25,
          topLeader: widget.leaders[0],
          rank: 3,
        ),
      ],
    );
  }

  void _listenToLeaderBoardState(BuildContext context, LeaderboardState state) {
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

class LeaderWidget extends StatelessWidget {
  const LeaderWidget({
    super.key,
    this.imageRadius,
    required this.topLeader,
    this.rank,
  });

  final double? imageRadius;
  final int? rank;

  final Leaders topLeader;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: imageRadius ?? 30,
              backgroundColor: Pallets.white,
              backgroundImage: NetworkImage(topLeader.user?.profilePhoto ?? ""),
            ),
            Positioned(
              bottom: -16,
              right: 0,
              left: 0,
              child: CustomActionButton(
                child: Center(
                  child: TextView(
                    text: rank.toString(),
                    color: Pallets.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
        16.verticalSpace,
        TextView(
          text: topLeader.user!.firstname ?? '',
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: Pallets.white,
        ),
        TextView(
          text: topLeader.totalAmountWon ?? '',
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: Pallets.white,
        )
      ],
    );
  }
}
