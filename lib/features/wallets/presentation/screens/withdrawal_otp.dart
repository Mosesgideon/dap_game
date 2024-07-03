import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/otp_field.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/wallets/presentation/widgets/wallet_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WithdrawalOTP extends StatefulWidget {
  const WithdrawalOTP({super.key});

  @override
  State<WithdrawalOTP> createState() => _WithdrawalOTPState();
}

class _WithdrawalOTPState extends State<WithdrawalOTP> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

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
              25.verticalSpace,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      const TextView(
                        text: "Please Enter Code",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      20.verticalSpace,
                      const TextView(
                        text:
                        "An OTP has been sent to your registered phone number that end with ***67",
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      40.verticalSpace,
                      Form(
                        key: _formKey,
                        onChanged: () {},
                        child: Center(
                          child: OtpField(
                            controller: _otpController,
                            count: 5,
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      Center(
                        child: TextButton(
                            style: TextButton.styleFrom(),
                            onPressed: () {
                              // _resendOtp();
                            },
                            child: const TextView(
                              text: 'Resend Code',
                              fontWeight: FontWeight.w600,
                              color: Pallets.orange,
                              fontSize: 15,
                            )),
                      ),
                      170.verticalSpace,
                      CustomButton(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                          borderRadius: BorderRadius.circular(25),
                          bgColor: Pallets.orange,
                          child: const TextView(
                            text: "Send OTP",
                          ),
                          onPressed: () {
                            CustomDialogs.success("Withdrawal Successful");

                            context.pushNamed(PageUrl.wallet);


                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
