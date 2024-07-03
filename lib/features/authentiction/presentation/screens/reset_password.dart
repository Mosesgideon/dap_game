import 'dart:developer';
import 'package:dap_game/common/widgets/circular_loader.dart';
import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/filled_textfield.dart';

import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/core/utils/validators.dart';
import 'package:dap_game/features/authentiction/data/repository/authrepository_impl.dart';
import 'package:dap_game/features/authentiction/presentation/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconsax/iconsax.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key, required this.email});

  final String email;

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final authbloc = AuthBloc(AuthRepositoryImpl(NetworkService()));
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  bool _passwordObscured = true;
  bool _confirmPasswordObscured = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Iconsax.arrow_left,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Center(
                //   child: ImageWidget(
                //     size: 90.h,
                //     imageUrl: Assets.images.pngs.logo.path,
                //   ),
                // ),
                // 30.verticalSpace,
                const TextView(
                  text: "Reset Password",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Pallets.darkblue),
                ),
                23.verticalSpace,
                const TextView(
                  text: "New Password",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey,
                ),
                12.verticalSpace,
                FilledTextField(
                  hint: "Enter new password",
                  controller: newPasswordController,
                  obscured: _passwordObscured,
                  hasElevation: false,
                  suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          _passwordObscured = !_passwordObscured;
                        });
                      },
                      child: Icon(!_passwordObscured
                          ? Iconsax.eye
                          : Iconsax.eye_slash)),
                  onChanged: (p0) {
                    setState(() {});
                  },
                  preffix: const Icon(Iconsax.lock),
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'This field is required'),
                    MinLengthValidator(8,
                        errorText: 'Password should be up to 8 characters.')
                  ]).call,
                  fillColor: Pallets.white,
                ),
                6.verticalSpace,
                const TextView(
                  text: "Must be at least 8 characters.",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey),
                ),
                23.verticalSpace,
                const TextView(
                  text: "Confirm Password",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey,
                ),
                12.verticalSpace,
                FilledTextField(
                  hint: "Confirm new password",
                  controller: confirmNewPasswordController,
                  obscured: _confirmPasswordObscured,
                  suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          _confirmPasswordObscured = !_confirmPasswordObscured;
                        });
                      },
                      child: Icon(!_confirmPasswordObscured
                          ? Iconsax.eye
                          : Iconsax.eye_slash)),
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'This field is required'),
                    MinLengthValidator(8,
                        errorText: 'Password should be up to 8 characters.'),
                    ConfirmPasswordValidator(
                        errorText: 'Password mismatch',
                        comparedPassword: newPasswordController.text)
                  ]).call,
                  preffix: const Icon(Iconsax.lock),
                  fillColor: Pallets.white,
                ),
                6.verticalSpace,
                const TextView(
                  text: "Both passwords must match.",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey),
                ),
                100.verticalSpace,
                BlocConsumer<AuthBloc, AuthState>(
                  bloc: authbloc,
                  listener: _listenToCreateNewPasswordState,
                  builder: (context, state) {
                    return CustomButton(
                      onPressed: state is! AuthLoadingState
                          ? () {
                              resetPassword();
                            }
                          : null,
                      bgColor: Pallets.orange,
                      borderRadius: BorderRadius.circular(25),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                      child: (state is AuthLoadingState)
                          ? const CircularLoader(
                              size: 20,
                            )
                          : const TextView(
                              text: "Resend Password",
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _listenToCreateNewPasswordState(BuildContext context, AuthState state) {
    if (state is AuthLoadingState) {
      log("loading");
    }
    if (state is AuthFailureState) {
      CustomDialogs.error(state.error);
      log("failed to create password");
    }
    if (state is PasswordChangeSuccessState) {
      CustomDialogs.success('Password Reset successfully please login');
      context.goNamed(PageUrl.signIn);
    }
  }

  void resetPassword() {
    if (_formKey.currentState!.validate()) {
      authbloc.add(CreateNewPasswordEvent(
          newPassword: newPasswordController.text.trim(),
          email: widget.email.trim(),
          password_confirmation: confirmNewPasswordController.text.trim()));
    }
  }
}
