import 'dart:math';
import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/error_widget.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/neumorphic_button.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/onboarding_texts.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/games/lottery/data/models/get_games_categories_models.dart';
import 'package:dap_game/features/games/spinwin/data/models/game_price.dart';
import 'package:dap_game/features/games/spinwin/data/models/update_game_payload.dart';
import 'package:dap_game/features/games/spinwin/presentation/bloc/spinwin_bloc.dart';
import 'package:dap_game/features/games/spinwin/presentation/widgets/buy_coin_sheet.dart';
import 'package:dap_game/features/games/spinwin/presentation/widgets/spin_won_dialog.dart';
import 'package:dap_game/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roulette/roulette.dart';

class SpinWinScreen extends StatefulWidget {
  const SpinWinScreen({super.key, required this.game});

  final DapGame game;

  @override
  State<SpinWinScreen> createState() => _SpinWinScreenState();
}

class _SpinWinScreenState extends State<SpinWinScreen>
    with SingleTickerProviderStateMixin {
  late RouletteController controller;
  var currentGameId;

  // Sample prices array
  List<GamePrice> get prices => [
        GamePrice(1, PriceType.multiple, 2),
        GamePrice(2, PriceType.multiple, 3),
        GamePrice(4, PriceType.specific, 0),
        GamePrice(3, PriceType.specific, 50),
        GamePrice(4, PriceType.specific, 0),
        GamePrice(5, PriceType.specific, 20),
        GamePrice(5, PriceType.specific, potentialWin),
        GamePrice(4, PriceType.specific, 0),
      ];

  int get potentialWin => int.parse(widget.game.potentialWin.replaceAll(".00", ""));
  final bloc = SpinwinBloc(injector.get());

  @override
  void initState() {
    injector.get<ProfileBloc>().add(GetProfileEvent());
    controller = RouletteController(
        group: RouletteGroup(List.generate(
            prices.length,
            (index) => RouletteUnit(
                color: Pallets.selectSpinBackgroundColor(index),
                weight: 1,
                text: prices[index].displayText))),
        vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      bloc: injector.get(),
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var user = injector.get<UserBloc>().appUser;
        return BlocConsumer<SpinwinBloc, SpinwinState>(
          bloc: bloc,
          listener: _listenToSpinWinBloc,
          builder: (context, state) {
            return Scaffold(
              appBar: CustomAppBar(
                tittleText: "Spin Win",
                actions: [
                  BlocBuilder<ProfileBloc, ProfileState>(
                    bloc: injector.get(),
                    builder: (context, profileState) {
                      return Row(
                        children: [
                          ImageWidget(imageUrl: Assets.images.pngs.coin.path),
                          5.horizontalSpace,
                          TextView(
                            text: profileState is ProfileLoadingState
                                ? "..."
                                : user?.coinWallet.balance,
                            style: GoogleFonts.sora(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          10.horizontalSpace,
                          TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Pallets.white,
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17, vertical: 4),
                                  backgroundColor: Pallets.primary),
                              onPressed: () {
                                CustomDialogs.showBottomSheet(
                                    context, BuyCoinSheet());
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const TextView(
                                    text: "Add coin",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  5.horizontalSpace,
                                  const Icon(
                                    Icons.add,
                                    color: Pallets.white,
                                    size: 16,
                                  ),
                                ],
                              )),
                          16.horizontalSpace
                        ],
                      );
                    },
                  )
                ],
              ),
              body: Stack(
                children: [
                  Column(
                    children: [
                      20.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(16.r)),
                          child: const TextView(text: spinWinInstruction),
                        ),
                      ),
                      30.verticalSpace,
                      Center(
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  12.verticalSpace,
                                  SizedBox(
                                    height: 0.8.sw,
                                    width: 0.8.sw,
                                    child: Roulette(
                                      controller: controller,
                                      style: RouletteStyle(
                                          centerStickerColor: Pallets.spinBg1,
                                          dividerThickness: 0,
                                          textLayoutBias: 0.7,
                                          textStyle:
                                              GoogleFonts.plusJakartaSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                          centerStickSizePercent: 0.06

                                          // Customize appearance
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: ImageWidget(
                                  imageUrl: Assets.images.pngs.spinArrow.path),
                            )
                          ],
                        ),
                      ),
                      50.verticalSpace,
                      Builder(builder: (context) {
                        if (injector.get<UserBloc>().appUser == null) {
                          return AppPromptWidget(
                            title: 'Sign in to continue',
                            message: 'Please sign in or register to play',
                            retryText: 'Sign in',
                            onTap: () {
                              context.pushNamed(PageUrl.signIn);
                            },
                          );
                        }

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 36.0.w),
                          child: CustomNeumorphicButton(
                              // expanded: false,
                              fgColor: Pallets.white,
                              text: "Start Spin (50 Coins)",
                              onTap: () async {
                                bloc.add(PlayGameEvent());
                              },
                              color: Pallets.primary),
                        );
                      })
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _listenToSpinWinBloc(
      BuildContext context, SpinwinState state) async {
    if (state is PlayGameLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is PlayGameSuccessState) {
      currentGameId = state.response.data.currentGame.id;
      context.pop();
      // Generate random offset
      final random = Random();
      final random2 = Random();
      final offset = random.nextDouble();
      int target = random2.nextInt(5);
      // if (target == 0) {
      //   target += 1;
      // }
      var amountWon = _getAmout(target);

      // Spin with offset
      await controller.rollTo(target, offset: offset);
      CustomDialogs.showBottomSheet(
        context,
        SpinWonDialog(
          amountWon: amountWon,
        ),
      );

      bloc.add(UpdateGameEvent(UpdateGamePayload(
          playId: currentGameId,
          playStatus: amountWon > 0 ? "won" : "lost",
          amount: amountWon)));
    }

    if (state is PlayGameFailedState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }

  _getAmout(int target) {
    var price = prices[target];

    if (price.type == PriceType.specific) {
      return price.value;
    } else {
      return price.value * 50;
    }
  }
}
