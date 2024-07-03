import 'package:dap_game/common/widgets/circular_loader.dart';
import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/filled_textfield.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/path_params.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/authentiction/data/repository/authrepository_impl.dart';
import 'package:dap_game/features/authentiction/presentation/auth_bloc/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconsax/iconsax.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var passwordResetMethod = 'email';
  final authbloc = AuthBloc(AuthRepositoryImpl(NetworkService()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Center(
            //   child: ImageWidget(
            //     size: 90.h,
            //     imageUrl: Assets.images.pngs.logo.path,
            //   ),
            // ),
            // 30.verticalSpace,
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextView(
                      text: "Forgotten Password",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Pallets.darkblue),
                    ),
                    16.verticalSpace,
                    const TextView(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        text:
                            "Enter the email associated with your account"),
                    16.verticalSpace,
                    FilledTextField(
                      controller: _emailController,
                      hint: "Email",
                      // enabled: true,
                      // hasBorder: false,
                      // hasBorder: false,
                      hasElevation: false,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                        EmailValidator(errorText: 'Enter a valid email.')
                      ]).call,

                      preffix: const Icon(Iconsax.user),
                      fillColor: Pallets.white,
                    ),
                  ],
                ),
              ),
            ),
            // const TextView(
            //   text: "Please select an option to reset your password",
            //   style: TextStyle(
            //       fontSize: 14,
            //       fontWeight: FontWeight.w300,
            //       color: Pallets.darkblue),
            // ),
            // 23.verticalSpace,
            // PasswordResetMethod(
            //   checked: passwordResetMethod == 'email',
            //   onTap: () {
            //     setState(() {
            //       passwordResetMethod = 'email';
            //     });
            //   },
            //   icon: Iconsax.message,
            //   title: "Reset With Email",
            //   subtitle:
            //       "Reset OTP will be send to your registered email \naddress",
            // ),
            // 23.verticalSpace,
            // PasswordResetMethod(
            //   checked: passwordResetMethod == 'phone',
            //   onTap: () {
            //     setState(() {
            //       passwordResetMethod = 'phone';
            //     });
            //   },
            //   icon: Iconsax.call_calling,
            //   title: "Reset With Phone number",
            //   subtitle:
            //       'Reset OTP will be send to your registered phone \nnumber',
            // ),
            // 23.verticalSpace,
            BlocConsumer<AuthBloc, AuthState>(
              listener: _listenToAuthState,
              bloc: authbloc,
              builder: (context, state) {
                return CustomButton(
                  onPressed: state is! AuthLoadingState
                      ? () {
                          _sentOTP();
                        }
                      : null,
                  bgColor: Pallets.orange,
                  borderRadius: BorderRadius.circular(25),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  child: (state is AuthLoadingState)
                      ? const CircularLoader(
                          size: 20,
                        )
                      : const TextView(
                          text: "Send OTP",
                        ),
                );
              },
            ),
            50.verticalSpace,
          ],
        ),
      ),
    );
  }

  void _sentOTP() {
    if (_formKey.currentState!.validate()) {
      authbloc.add(SendOtpEvent(_emailController.text.trim()));
    }
  }

  void _listenToAuthState(BuildContext context, AuthState state) {
    if (state is AuthFailureState) {
      CustomDialogs.error(state.error);
    }
    if (state is OtpSentSuccessState) {
      CustomDialogs.success("OTP sent");
      context.pushNamed(PageUrl.otpPage,
          queryParameters: {PathParam.email: _emailController.text.trim()});
    }
    if (state is AuthLoadingState) {}
  }
}
