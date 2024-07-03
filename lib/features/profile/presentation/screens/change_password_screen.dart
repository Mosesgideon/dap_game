import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/filled_textfield.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/core/utils/validators.dart';
import 'package:dap_game/features/profile/data/repository/account_repository_impl.dart';
import 'package:dap_game/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconsax/iconsax.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _obscureOldPassword = true;

  bool _obscureNewPassword = true;

  bool _obscureConfirmNewPassword = true;

  final TextEditingController oldPasswordController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  final updateBloc = ProfileBloc(AccountRepositoryImpl(NetworkService()));
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        tittleText: "Change password",
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: updateBloc,
        listener: _listenToChangePasswordEvent,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  23.verticalSpace,
                  FilledTextField(
                    hasElevation: false,
                    controller: oldPasswordController,
                    hint: "Old Password",
                    obscured: _obscureOldPassword,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'This field is required'),
                      MinLengthValidator(8,
                          errorText: 'Password should be up to 8 characters.')
                    ]).call,
                    preffix: const Icon(Iconsax.lock),
                    fillColor: Pallets.white,
                    suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureOldPassword = !_obscureOldPassword;
                          });
                        },
                        child: Icon(!_obscureOldPassword
                            ? Iconsax.eye
                            : Iconsax.eye_slash)),
                  ),
                  24.verticalSpace,
                  FilledTextField(
                    hasElevation: false,
                    obscured: _obscureNewPassword,
                    hint: "New Password",
                    suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureNewPassword = !_obscureNewPassword;
                          });
                        },
                        child: Icon(!_obscureOldPassword
                            ? Iconsax.eye
                            : Iconsax.eye_slash)),
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'This field is required'),
                      MinLengthValidator(8,
                          errorText: 'Password should be up to 8 characters.')
                    ]).call,
                    controller: newPasswordController,
                    onChanged: (p0) {
                      setState(() {});
                    },
                    preffix: const Icon(Iconsax.lock),
                    fillColor: Pallets.white,
                  ),
                  24.verticalSpace,
                  FilledTextField(
                    hasElevation: false,
                    obscured: _obscureConfirmNewPassword,
                    hint: "Confirm New Password",
                    onChanged: (p0) {
                      setState(() {});
                    },
                    suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureConfirmNewPassword =
                                !_obscureConfirmNewPassword;
                          });
                        },
                        child: Icon(!_obscureOldPassword
                            ? Iconsax.eye
                            : Iconsax.eye_slash)),
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'This field is required'),
                      MinLengthValidator(8,
                          errorText: 'Password should be up to 8 characters.'),
                      ConfirmPasswordValidator(
                          errorText: "Password mismatch",
                          comparedPassword: newPasswordController.text)
                    ]).call,
                    controller: confirmNewPasswordController,
                    preffix: const Icon(Iconsax.lock),
                    fillColor: Pallets.white,
                  ),
                  24.verticalSpace,
                  CustomButton(
                    onPressed: () {
                      _changePassword();
                    },
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 18),
                    borderRadius: BorderRadius.circular(25),
                    bgColor: Pallets.orange,
                    child: const Text("Change Password"),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      updateBloc.add(ProfileUpdatedEvent(
          password: newPasswordController.text,
          oldPassword: oldPasswordController.text));
    }
  }

  void _listenToChangePasswordEvent(BuildContext context, ProfileState state) {
    if (state is ProfileLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is ProfileUpdateSuccessState) {
      CustomDialogs.success("Password changed");
      context.goNamed(PageUrl.home);
    }
    if (state is ProfileFailureState) {
      logger.e(state.error);
      CustomDialogs.error(state.error);
    }
  }
}
