import 'package:dap_game/common/widgets/action_button.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/leaderboard/data/models/leaderboard_response.dart';
import 'package:dap_game/features/leaderboard/data/repository_impl/leaderboad_repo_impl.dart';
import 'package:dap_game/features/leaderboard/presentations/bloc/leaderboard_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaderList extends StatefulWidget {
  final List<Leaders> leaders;

  const LeaderList({super.key, required this.leaders});

  @override
  State<LeaderList> createState() => _LeaderListState();
}

class _LeaderListState extends State<LeaderList> {
  @override
  void initState() {
    // leaderbloc.add(LeaderBoardFetchedEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Leaders> remainingleaders =
        widget.leaders.length > 3 ? widget.leaders.sublist(2) : [];
    final itemCount = remainingleaders.length;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Pallets.primaryLight),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 40,
                        decoration: const BoxDecoration(
                            color: Pallets.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: Center(
                          child: TextView(
                            align: TextAlign.center,
                            text: (index + 4).toString(),
                            color: Pallets.red,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            remainingleaders[index].user?.profilePhoto ?? ''),
                      ),
                      10.horizontalSpace,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text: remainingleaders[index].user!.firstname ??
                                remainingleaders[index].user!.username ??
                                "",
                            color: Pallets.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                          3.horizontalSpace,
                          TextView(
                            text: remainingleaders[index].user!.lastname ?? '',
                            color: Pallets.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      )
                    ],
                  ),
                  TextView(
                    text: remainingleaders[index].totalAmountWon ?? '',
                    color: Pallets.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
//
// void _listenToLeaderBoardState(BuildContext context, LeaderboardState state) {
//   if (state is LeaderBoardLoadingState) {
//     CustomDialogs.showLoading(context);
//   }
//   if (state is LeaderBoardSuccessState) {}
//   if (state is LeaderBoardFailureState) {
//     CustomDialogs.success(state.error);
//   }
// }
}
