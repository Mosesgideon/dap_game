import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/error_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/games/lottery/presentation/bloc/lottery_game_bloc.dart';
import 'package:dap_game/features/games/lottery/presentation/bloc/lottery_game_bloc.dart';
import 'package:dap_game/features/games/lottery/presentation/widget/draw_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectDrawScreen extends StatefulWidget {
  const SelectDrawScreen({super.key, required this.gameId});

  final String gameId;

  @override
  State<SelectDrawScreen> createState() => _SelectDrawScreenState();
}

class _SelectDrawScreenState extends State<SelectDrawScreen> {
  final _bloc = LotteryGameBloc(injector.get());

  @override
  void initState() {
    _bloc.add(GetGameDrawsEvent(widget.gameId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        tittleText: 'Select Draw',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: TextView(
                  text: 'Select a draw from here to view its results.',
                  fontSize: 15,
                  color: Pallets.primary,
                ),
              ),
            ),
            // const TextView(text: 'Sort by',fontWeight: FontWeight.w500,),
            // 5.verticalSpace,
            // InkWell(
            //   onTap: () {
            //     _selectDate();
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: context.colorScheme.surface,
            //         borderRadius: BorderRadius.circular(6.r)),
            //     child: Padding(
            //       padding: const EdgeInsets.all(10.0),
            //       child: Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           const Icon(Iconsax.calendar),
            //           8.horizontalSpace,
            //           const TextView(
            //             text: '20-03-2024',
            //             fontSize: 15,
            //             fontWeight: FontWeight.w600,
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            16.verticalSpace,
            Expanded(
                child: BlocConsumer<LotteryGameBloc, LotteryGameState>(
              bloc: _bloc,
              listener: _listenToLotteryGameBloc,
              builder: (context, state) {
                if (state is GetGameDrawsLoading) {
                  return Center(
                    child: CustomDialogs.getLoading(size: 30),
                  );
                }

                if (state is GetGameDrawsFailureState) {
                  return Center(
                    child: AppPromptWidget(
                      message: state.error,
                      onTap: () {
                        _bloc.add(GetGameDrawsEvent(widget.gameId));
                      },
                    ),
                  );
                }

                if (state is GetGameDrawsSuccessState) {
                  if (state.response.data.draws.isEmpty) {
                    return Center(
                      child: AppPromptWidget(
                        title: 'There are no draws here',
                        message: 'Refresh to get updates',
                        onTap: () {
                          _bloc.add(GetGameDrawsEvent(widget.gameId));
                        },
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: state.response.data.draws.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: DrawWidget(
                        draw: state.response.data.draws[index],
                      ),
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

  void _listenToLotteryGameBloc(BuildContext context, LotteryGameState state) {}

  void _selectDate() {
    showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(1800));
  }
}
