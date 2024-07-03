import 'package:dap_game/common/widgets/circular_loader.dart';
import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/custom_countdown.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/otp_field.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/navigation/path_params.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/authentiction/presentation/auth_bloc/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTPScreen extends StatefulWidget {
  final String email;

  const OTPScreen({super.key, required this.email});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authbloc = AuthBloc(injector.get());
  DateTime _countDownEndTime = DateTime.now().add(const Duration(minutes: 1));
  bool isCounting = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextView(
                    text: "Verify Otp",
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  10.verticalSpace,
                  TextView(
                    text:
                        "Please provide the 5-Digit code sent to your email ${widget.email}",
                    // fontSize: 14,
                    // fontWeight: FontWeight.w500,
                  ),
                  23.verticalSpace,
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
                  if (isCounting != true)
                    Center(
                      child: TextButton(
                          style: TextButton.styleFrom(),
                          onPressed: () {
                            _resendOtp();
                          },
                          child: const TextView(
                            text: 'Resend Code',
                            fontWeight: FontWeight.w600,
                            color: Pallets.orange,
                            fontSize: 15,
                          )),
                    ),
                  if (isCounting == true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextView(
                          text: 'Request a new code in ',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Pallets.grey,
                        ),
                        CustomCountDown(
                          endTime: _countDownEndTime,
                          onEnd: () {
                            isCounting = false;
                            // setState(() {});
                          },
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            42.verticalSpace,
            BlocConsumer<AuthBloc, AuthState>(
              listener: _listenToAuthState,
              bloc: authbloc,
              builder: (context, state) {
                return CustomButton(
                  borderRadius: BorderRadius.circular(25),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  bgColor: Pallets.orange,
                  onPressed: _otpController.text.length != 5
                      ? null
                      : () => _verifyOtp(),
                  child: (state is AuthLoadingState)
                      ? const CircularLoader(
                          size: 20,
                        )
                      : const TextView(
                          text: "Continue",
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _listenToAuthState(BuildContext context, AuthState state) {
    if (state is AuthFailureState) {
      CustomDialogs.error(state.error);
      // log("error");
    }
    if (state is OtpVerificationSuccessState) {
      CustomDialogs.success("OTP verified");
      // log("verified");
      context.pushNamed(PageUrl.passwordReset,
          queryParameters: {PathParam.email: widget.email});
    }

    if (state is OtpSentSuccessState) {
      CustomDialogs.success("OTP sent");
      isCounting = true;
      _otpController.clear();

      // if(mounted)
      // setState(() {});
    }

    if (state is AuthLoadingState) {}
  }

  _verifyOtp() {
    if (_formKey.currentState!.validate()) {
      authbloc.add(
          VerifyOtpEvent(otp: _otpController.text.trim(), email: widget.email));
    }
  }

  void _resendOtp() {
    authbloc.add(SendOtpEvent(widget.email));
  }
}
