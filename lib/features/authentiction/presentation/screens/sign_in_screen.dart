import 'dart:developer';
import 'package:dap_game/common/widgets/circular_loader.dart';
import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/custom_checkbox.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/filled_textfield.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/authentiction/presentation/auth_bloc/auth_bloc.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dap_game/core/di/injector.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _rememberMe = false;
  final _fullnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authbloc = AuthBloc(injector.get());
  var _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                70.verticalSpace,
                Center(
                  child: ImageWidget(
                    size: 90.h,
                    imageUrl: Assets.images.pngs.logo.path,
                  ),
                ),
                30.verticalSpace,
                const TextView(
                  text: "Login",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Pallets.darkblue),
                ),
                23.verticalSpace,
                FilledTextField(
                  hasElevation: false,
                  controller: _fullnameController,
                  hint: "email/username",
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'This field is required'),
                    // EmailValidator(errorText: 'Enter a valid email'),
                  ]).call,
                  preffix: const Icon(Iconsax.user),
                  fillColor: Pallets.white,
                ),
                24.verticalSpace,
                FilledTextField(
                  hasElevation: false,
                  obscured: _obscure,
                  hint: "Password",
                  suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                      child: Icon(!_obscure ? Iconsax.eye : Iconsax.eye_slash)),
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'This field is required'),
                    MinLengthValidator(8,
                        errorText: 'Password should be up to 8 characters.')
                  ]).call,
                  controller: _passwordController,
                  preffix: const Icon(Iconsax.lock),
                  fillColor: Pallets.white,
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomCheckBox(
                          onChecked: (bool val) {
                            _rememberMe = val;
                            setState(() {});
                          },
                          value: _rememberMe,
                          trailing: const TextView(
                            text: "Remember me",
                            style: TextStyle(
                                fontSize: 14, color: Pallets.darkblue),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          context.pushNamed(PageUrl.forgotPassword);
                        },
                        child: const TextView(
                            text: 'Forgotten password?',
                            style:
                                TextStyle(fontSize: 14, color: Pallets.orange)))
                  ],
                ),
                32.verticalSpace,
                BlocConsumer<AuthBloc, AuthState>(
                  bloc: authbloc,
                  listener: _listenToAuthState,
                  builder: (context, state) {
                    return CustomButton(
                      onPressed: state is! AuthLoadingState
                          ? () {
                              _signInUser();
                            }
                          : null,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 18),
                      borderRadius: BorderRadius.circular(25),
                      bgColor: Pallets.orange,
                      child: const Text("Login"),
                    );
                  },
                ),
                32.verticalSpace,
                _orWidget(),
                32.verticalSpace,
                // OptionAuthSignInMethod(),
                OutlinedGoogleButton(
                  onPressed: () {
                    authbloc.add(GoogleSignInEvent());
                  },
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(25),
                  bgColor: Pallets.normalwhite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageWidget(imageUrl: Assets.images.pngs.google.path),
                      10.horizontalSpace,
                      const TextView(
                        text: "Google",
                        style: TextStyle(
                            color: Pallets.darkblue,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                32.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextView(
                      text: "Don’t have an Account?",
                      style: TextStyle(
                          color: Pallets.darkblue,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    5.horizontalSpace,
                    TextView(
                      onTap: () {
                        context.pushNamed(PageUrl.signUp);
                      },
                      text: "Click here to register",
                      style: const TextStyle(
                          color: Pallets.orange,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _orWidget() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 130,
          child: Divider(
            color: Pallets.darkblue,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextView(
            text: "OR",
            style: TextStyle(
                color: Pallets.darkblue,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          width: 130,
          child: Divider(
            color: Pallets.darkblue,
          ),
        ),
      ],
    );
  }

  void _listenToAuthState(BuildContext context, AuthState state) {
    if (state is AuthLoadingState) {
      log("login in progress");
      CustomDialogs.showLoading(context);
    }
    if (state is AuthGoogleLoagingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is AuthFailureState) {
      context.pop();
      log(state.error);
      CustomDialogs.error(state.error);
    }
    if (state is AuthSuccessState) {
      log("success");
      CustomDialogs.success("Login successful");
      context.goNamed(PageUrl.home);
    }
    if (state is AuthGoogleSuccessState) {
      log("success");
      CustomDialogs.success("Login successful");
      context.goNamed(PageUrl.home);
    }
  }

  void _signInUser() {
    if (_formKey.currentState!.validate()) {
      authbloc.add(SignInEvent(
          _fullnameController.text.trim(), _passwordController.text.trim()));
    }
  }
}
