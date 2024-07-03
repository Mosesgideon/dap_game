import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/games/spinwin/presentation/widgets/coin_amount_sheet.dart';
import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:dap_game/features/wallets/presentation/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyCoinSheet extends StatelessWidget {
  BuyCoinSheet({super.key});

  final bloc = WalletBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletBloc, WalletState>(
      bloc: bloc,
      listener: _listenToWalletBloc,
      builder: (context, state) {
        return Container(
          // height: 0.5.sh,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Pallets.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              5.verticalSpace,
              Row(
                children: [
                  ImageWidget(imageUrl: Assets.images.pngs.coin.path),
                  5.horizontalSpace,
                  TextView(
                    text: "Top up coin",
                    style: GoogleFonts.sora(
                      color: Pallets.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              InkWell(
                onTap: () async {
                  double? amount = await CustomDialogs.showCustomDialog(
                      const CoinAmountSheet(), context);
                  if (amount != null) {
                    bloc.add(SwapCoinEvent(
                        amount: amount.toDouble() ?? 0, swapType: "to_coin"));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundColor: Colors.grey.shade100,
                        child: const Icon(
                          Icons.wallet_rounded,
                          color: Pallets.primary,
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              text: "Top up  from wallet",
                              style: GoogleFonts.sora(
                                color: Pallets.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            5.verticalSpace,
                            TextView(
                              text:
                                  "\$${injector.get<UserBloc>().appUser?.wallet.balance}",
                              style: GoogleFonts.sora(
                                color: Pallets.primary,
                                // fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Pallets.primary,
                        size: 16,
                      ),
                      10.horizontalSpace
                    ],
                  ),
                ),
              ),
              30.verticalSpace,
            ],
          ),
        );
      },
    );
  }

  void _listenToWalletBloc(BuildContext context, WalletState state) {
    if (state is SwapCoinLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is SwapCoinFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is SwapCoinSuccessState) {
      context.pop();
      context.pop();
      CustomDialogs.success("Coin funded successfully");
    }
  }
}
