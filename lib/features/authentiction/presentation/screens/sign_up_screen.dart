import 'dart:io';
import 'package:dap_game/common/widgets/circular_loader.dart';
import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/custom_checkbox.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/filled_textfield.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/services/firebase/notifiactions.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/core/utils/time_util.dart';
import 'package:dap_game/features/authentiction/data/models/register_payload.dart';
import 'package:dap_game/features/authentiction/data/repository/authrepository_impl.dart';
import 'package:dap_game/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:dap_game/features/profile/presentation/bloc/profile/profile_bloc.dart';

import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconsax/iconsax.dart';

import '../auth_bloc/auth_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _referalController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authbloc = AuthBloc(AuthRepositoryImpl(NetworkService()));
  bool isClickable = true;
  var _obscure = true;

  DateTime? dob;

  final _dobController = TextEditingController();

  bool referralEnabled = false;

  get _referralCrossfade =>
      referralEnabled ? CrossFadeState.showFirst : CrossFadeState.showSecond;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                70.verticalSpace,
                Center(
                  child: ImageWidget(
                    size: 90.h,
                    imageUrl: Assets.images.pngs.logo.path,
                  ),
                ),
                20.verticalSpace,
                const TextView(
                  text: "Sign Up",
                  style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                23.verticalSpace,
                FilledTextField(
                  controller: _fullnameController,
                  hint: "Username",
                  hasElevation: false,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'This field is required')
                  ]).call,
                  preffix: const Icon(Iconsax.profile_add),
                  fillColor: Pallets.white,
                ),
                24.verticalSpace,
                FilledTextField(
                  controller: _emailController,
                  hint: "Email",
                  hasElevation: false,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'This field is required'),
                    EmailValidator(errorText: 'Enter a valid email.')
                  ]).call,
                  preffix: const Icon(Iconsax.user),
                  fillColor: Pallets.white,
                ),
                24.verticalSpace,
                FilledTextField(
                  controller: _passwordController,
                  hint: "Password",
                  hasElevation: false,
                  suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                      child: Icon(
                          !_obscure ? Iconsax.eye : Iconsax.eye_slash)),
                  obscured: _obscure,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'This field is required'),
                    MinLengthValidator(8,
                        errorText: 'Password should be up to 8 characters.')
                  ]).call,
                  preffix: Icon(Iconsax.lock),
                  fillColor: Pallets.white,
                ),
                20.verticalSpace,

                InkWell(
                  onTap: () {
                    _selectDateOfBirth();
                  },
                  child: FilledTextField(
                    controller: _dobController,
                    hint: "Date of birth",
                    enabled: false,
                    hasElevation: false,
                    validator:
                    RequiredValidator(errorText: 'Field is required')
                        .call,
                    preffix: const Icon(Iconsax.calendar),
                    fillColor: Pallets.white,
                  ),
                ),
                20.verticalSpace,
                CustomCheckBox(
                    trailing: const TextView(
                        text: "Do you have a referral code ?"),
                    onChecked: (val) {
                      referralEnabled = !referralEnabled;
                      setState(() {});
                    },
                    value: referralEnabled),

                AnimatedCrossFade(
                  crossFadeState: _referralCrossfade,
                  secondChild: 0.verticalSpace,
                  firstChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.verticalSpace,
                      FilledTextField(
                        controller: _referalController,
                        hint: "Referral code(Optional)",
                        hasElevation: false,
                        obscured: true,
                        preffix: const Icon(Iconsax.people),
                        fillColor: Pallets.white,
                      ),
                    ],
                  ),
                  duration: const Duration(milliseconds: 300),
                ),
                32.verticalSpace,
                BlocConsumer<AuthBloc, AuthState>(
                  listener: _listenToAuthState,
                  bloc: authbloc,
                  builder: (context, state) {
                    return CustomButton(
                      onPressed: state is! AuthLoadingState
                          ? () {
                        _signupUser();
                      }
                          : null,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      borderRadius: BorderRadius.circular(25),
                      bgColor: Pallets.orange,
                      child: Text("Sign Up"),
                    );
                  },
                ),
                32.verticalSpace,
                _orWidget(),
                32.verticalSpace,
                // const OptionAuthSignInMethod(),
                OutlinedGoogleButton(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 15),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(25),
                  onPressed: () async {
                    await _selectDateOfBirth();

                    if (dob != null) {
                      authbloc.add(GoogleSignInEvent(dob: dob));
                    }
                  },
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
                      text: "Already registered?",
                      style: TextStyle(
                          color: Pallets.darkblue,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    TextView(
                      onTap: () {
                        context.pushNamed(PageUrl.signIn);
                      },
                      text: " Click here to login",
                      style: const TextStyle(
                          color: Pallets.orange,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                30.verticalSpace,
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
      CustomDialogs.showLoading(context);
    }
    if (state is AuthGoogleLoagingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is AuthFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is AuthSuccessState) {
      CustomDialogs.success(
        "Sign up successful",
      );
      context.goNamed(PageUrl.home);
    }
    if (state is AuthGoogleSuccessState) {
      // log("success");
      googleAuthSuccess(state, context);
    }
  }

  void googleAuthSuccess(
      AuthGoogleSuccessState state, BuildContext context) async {
    // log("success");
    CustomDialogs.success(
      "Sign up successful",
    );
    context.goNamed(PageUrl.home);

    // if (state.response.data.user.dob == null) {
    //   CustomDialogs.showToast(
    //     "Please select update your date of birth",
    //   );
    //   var _dob = await showDatePicker(
    //       context: context,
    //       helpText: "Select date of birth",
    //       initialDate: DateTime.now().subtract(const Duration(days: 360 * 18)),
    //       firstDate: DateTime(1800),
    //       lastDate: DateTime.now().subtract(const Duration(days: 360 * 18)));
    //
    //   if (_dob != null) {
    //     dob = _dob;
    //     _dobController.text = TimeUtil.formatDate(dob.toString());
    //   }
    // } else {
    // }
  }

  Future _selectDateOfBirth() async {
    var _dob = await showDatePicker(
        context: context,
        helpText: "Select date of birth",
        initialDate: DateTime.now().subtract(const Duration(days: 360 * 18)),
        firstDate: DateTime(1800),
        lastDate: DateTime.now().subtract(const Duration(days: 360 * 18)));

    if (_dob != null) {
      dob = _dob;
      _dobController.text = TimeUtil.formatDate(dob.toString());
      setState(() {});
    }
  }

  void _signupUser() {
    if (_formKey.currentState!.validate()) {
      authbloc.add(SignUpEvent(RegisterPayload(
          username: _fullnameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          referral: _referalController.text,
          deviceToken: notiToken,
          devicePlatform: Platform.operatingSystem,
          dob: dob!)));
    }
  }
}
