import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/services/payment/payment_handler.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/core/utils/string_extension.dart';
import 'package:dap_game/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:dap_game/features/wallets/presentation/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:dap_game/features/wallets/presentation/widgets/amount_sheet.dart';
import 'package:dap_game/features/wallets/presentation/widgets/swap_coin_sheet.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uuid/uuid.dart';

enum WalletType { cash, coin }

class WalletCard extends StatefulWidget {
  const WalletCard({super.key});

  @override
  State<WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  final bloc = ProfileBloc(injector.get());
  WalletType currentWalletType = WalletType.cash;
  var user = injector.get<UserBloc>().appUser;

  String get balance => currentWalletType == WalletType.cash
      ? "\$${user?.wallet.balance.toString().formatAmount()}"
      : "${user?.coinWallet.balance.toString().formatAmount(symbol: '')}";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: _listenToUserBloc,
      bloc: injector.get(),
      builder: (context, state) {
        return Container(
          width: 1.sw,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              image: DecorationImage(
                  image: Assets.images.jpegs.walletBg.provider(),
                  fit: BoxFit.cover)),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PopupMenuButton<WalletType>(
                    position: PopupMenuPosition.under,
                    onSelected: (value) => setState(() {
                      currentWalletType = value;
                    }),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r)),
                    child: IgnorePointer(
                      ignoring: true,
                      child: TextButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.r),
                                side: const BorderSide(
                                  color: Pallets.white,
                                ))),
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextView(
                              text: "Total ${currentWalletType.name} balance",
                              style: GoogleFonts.sora(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Pallets.white,
                              ),
                            ),
                            3.horizontalSpace,
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Pallets.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    itemBuilder: (context) {
                      return WalletType.values
                          .map((e) => PopupMenuItem(
                              value: e,
                              child: TextView(
                                text: "Total ${e.name.capitalizeFirst} balance",
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Pallets.black,
                              )))
                          .toList();
                    },
                  ),
                  // const,
                  10.horizontalSpace,
                  4.verticalSpace,

                  Builder(builder: (context) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (currentWalletType == WalletType.coin)
                          const Icon(
                            Iconsax.coin5,
                            size: 20,
                            color: Pallets.white,
                          ),
                        TextView(
                          text: balance,
                          style: GoogleFonts.sora(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w700,
                              color: Pallets.white),
                        ),
                      ],
                    );
                  }),
                  10.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _WalletAction(
                          icon: ImageWidget(
                            imageUrl: Assets.images.svgs.withdraw,
                            size: 16,
                          ),
                          tittle: 'Withdraw',
                          onTap: () {
                            context.pushNamed(PageUrl.withdrawal_screen);
                          },
                        ),
                        Container(
                          height: 20,
                          width: 1,
                          color: Colors.white,
                        ),
                        _WalletAction(
                          icon: ImageWidget(
                            imageUrl: Assets.images.svgs.deposit,
                            size: 16,
                          ),
                          tittle: 'Deposit',
                          onTap: () {
                            _deposit(context);
                          },
                        ),
                        Container(
                          height: 20,
                          width: 1,
                          color: Pallets.white,
                        ),
                        _WalletAction(
                          icon: ImageWidget(
                            imageUrl: Assets.images.svgs.swap,
                            size: 18,
                          ),
                          tittle: 'Swap coin',
                          onTap: () {
                            _swap(context);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Positioned(child: )
            ],
          ),
        );
      },
    );
  }

  _deposit(BuildContext context) async {
    var amount =
        await CustomDialogs.showBottomSheet(context, const AmountSheet());
    if (amount != null) {
      var user = injector.get<UserBloc>().appUser!;
      var ref = await PaymentHelper().makePayment(
          context,
          FlutterRequirements(
              email: user.email,
              fullName: user.username,
              phoneNumber: user.email,
              amount: amount,
              referenceNumber: const Uuid().v1()));

      logger.i(ref.toString());

      if (ref != null) {
        bloc.add(GetProfileEvent());
        injector.get<WalletBloc>().add(GetWalletDetailsEvent());
        CustomDialogs.success('Deposit Successful');
      } else {
        CustomDialogs.error('Transaction failed');
      }

      // paymentBloc
      //     .initializePayment(_amountController.text);
    }
  }

  _swap(BuildContext context) {
    CustomDialogs.showBottomSheet(context, const SwapCoinSheet());
  }

  void _listenToUserBloc(BuildContext context, UserState state) {}
}

class _WalletAction extends StatelessWidget {
  const _WalletAction(
      {super.key,
      required this.icon,
      required this.tittle,
      required this.onTap});

  final Widget icon;
  final String tittle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // height: 45.h,
        // width: 45.w,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              8.verticalSpace,
              TextView(
                text: tittle,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Pallets.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
