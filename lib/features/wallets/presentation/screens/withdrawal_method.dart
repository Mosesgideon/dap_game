import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/wallets/presentation/widgets/wallet_appbar.dart';
import 'package:dap_game/features/wallets/presentation/widgets/withdrawmethod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class WithdrawalMethod extends StatefulWidget {
  const WithdrawalMethod({super.key});

  @override
  State<WithdrawalMethod> createState() => _WithdrawalMethodState();
}

class _WithdrawalMethodState extends State<WithdrawalMethod> {
  var passwordResetMethod = 'email';
  bool ischecked=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WalletAppBar(),
              24.verticalSpace,
              const TextView(
                text: "Withdraw Funds",
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Pallets.darkblue,
              ),
              20.verticalSpace,
              const TextView(
                text:
                    "Please select an option to receive an OTP and complete the withdrawal request.",
                color: Pallets.darkblue,
              ),
              40.verticalSpace,

              WithdrawalResetMethod(
                checked: passwordResetMethod == 'email',
                onTap: () {
                  setState(() {
                    passwordResetMethod = 'email';
                  });
                },
                icon: Iconsax.message,
                title: "Receive With Email",
                subtitle:
                    "OTP to complete your withdrawal will be send\nto your registered email address",

              ),
              23.verticalSpace,
              WithdrawalResetMethod(
                checked: passwordResetMethod == 'phone',
                onTap: () {
                  setState(() {
                    passwordResetMethod = 'phone';
                  });
                },
                icon: Iconsax.call_calling,
                title: "Receive With SMS",
                subtitle:
                    'OTP to complete your withdrawal will be send \nto your registered phone number',

              ),
              60.verticalSpace,
              CustomButton(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  borderRadius: BorderRadius.circular(25),
                  bgColor: Pallets.orange,
                  child: const TextView(
                    text: "Send OTP",
                  ),
                  onPressed: () {
                    // context.pushNamed(PageUrl.withdrawal_otp);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
