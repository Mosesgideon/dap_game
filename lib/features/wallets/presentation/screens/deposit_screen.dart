import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/wallets/presentation/widgets/fund_method.dart';
import 'package:dap_game/features/wallets/presentation/widgets/wallet_appbar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  var fundmethod = 'card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              const WalletAppBar(),
              20.verticalSpace,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextView(
                    text: "Fund Wallet",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  20.verticalSpace,
                  const TextView(
                    text: "You can fund your wallet through the options listed below",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Pallets.darkblue,
                  ),
                  18.verticalSpace,
                  FundWalletMethod(
                    checked: fundmethod == 'card',
                    onTap: () {
                      fundmethod = 'card';
                    },
                    icon: Iconsax.wallet,
                    title: 'Fund with card',
                    subtitle: 'Fund your account with your debit/credit card',
                  ),
                  23.verticalSpace,
                  FundWalletMethod(
                    checked: fundmethod == 'bank',
                    onTap: () {
                      fundmethod = 'bank';
                    },
                    icon: Iconsax.bank,
                    title: 'Fund through bank transfer',
                    subtitle: 'Fund your account through your bank app',
                  ),
                  60.verticalSpace,
                  CustomButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                      borderRadius: BorderRadius.circular(25),
                      bgColor: Pallets.orange,
                      child: const TextView(
                        text: "Continue",
                      ),
                      onPressed: () {
                        // context.pushNamed(PageUrl.fund_card);
                      }),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
