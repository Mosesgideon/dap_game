import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/error_widget.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/core/utils/extensions/context_extension.dart';
import 'package:dap_game/features/games/lottery/presentation/bloc/lottery_game_bloc.dart';
import 'package:dap_game/features/games/lottery/presentation/screen/lottery_draw_results.dart';
import 'package:dap_game/features/games/lottery/presentation/screen/lottery_draw_winners.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawResultSheet extends StatefulWidget {
  const DrawResultSheet({super.key, required this.drawId});

  final String drawId;

  @override
  State<DrawResultSheet> createState() => _DrawResultSheetState();
}

class _DrawResultSheetState extends State<DrawResultSheet>
    with SingleTickerProviderStateMixin {
  final _bloc = LotteryGameBloc(injector.get());

  @override
  void initState() {
    _bloc.add(GetDrawResultEvent(widget.drawId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      constraints: BoxConstraints(maxHeight: 0.8.sh),

      decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r), topLeft: Radius.circular(20.r))),
      // constraints: BoxConstraints(maxHeight: 0.75.sh),
      child: BlocConsumer<LotteryGameBloc, LotteryGameState>(
        listener: _listenToLotteryGameBloc,
        bloc: _bloc,
        builder: (context, state) {
          if (state is GetDrawResultsLoading) {
            return Center(
              child: CustomDialogs.getLoading(size: 30),
            );
          }

          if (state is GetDrawResultsFailureState) {
            return Center(
              child: AppPromptWidget(
                message: state.error,
                onTap: () {
                  _bloc.add(GetDrawResultEvent(widget.drawId));
                },
              ),
            );
          }

          if (state is GetDrawResultsSuccessState) {
            if(state.response.data.draws.result == null){
              return AppPromptWidget(

                title: 'No Result yet',
                message: 'You will be updated once there is a result for this draw',
                onTap: () {
                  _bloc.add(GetDrawResultEvent(widget.drawId));

                },);
            }
            return DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    unselectedLabelColor: Pallets.darkblue,
                    indicatorColor: Pallets.orange,
                    labelColor: Pallets.grey,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.symmetric(vertical: 5),
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 5),
                    tabs: [
                      Text(
                        "Results",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Pallets.darkblue),
                      ),
                      Text("Winners",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Pallets.darkblue)),
                    ],
                  ),
                  16.verticalSpace,
                  Expanded(
                    child: TabBarView(
                      children: [
                        LotteryDrawResults(
                            results:
                                state.response.data.draws.result?.results !=
                                        null
                                    ? state.response.data.draws.result!.results
                                    : []),
                        LotteryDrawWinners(
                          winners: state.response.winners(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return 0.verticalSpace;
        },
      ),
    );
  }

  void _listenToLotteryGameBloc(BuildContext context, LotteryGameState state) {}
}
