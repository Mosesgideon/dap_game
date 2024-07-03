import 'dart:developer';

import 'package:dap_game/common/widgets/circular_loader.dart';
import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/filled_textfield.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/profile/data/models/delete_account_payload.dart';
import 'package:dap_game/features/profile/data/repository/account_repository_impl.dart';
import 'package:dap_game/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:dap_game/features/settings/presentations/widgets/delete_account_reason.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconsax/iconsax.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final deleteBloc = ProfileBloc(AccountRepositoryImpl(NetworkService()));
  final reasonController = TextEditingController();
  final passwordController = TextEditingController();
  final _forkey = GlobalKey<FormState>();
  String selectedReason = "";

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
              Icons.arrow_back_ios_new,size: 20,
              color: Pallets.darkblue,
            )),
        title: const TextView(
          text: "Delete Account",
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Pallets.darkblue,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _forkey,
            child: Column(
              children: [
                ImageWidget(
                  imageUrl: Assets.images.pngs.deleteaccount.path,
                  size: 100,
                ),
                20.verticalSpace,
                const TextView(
                  text: "Are you sure you want to delete your account",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  align: TextAlign.center,
                ),
                20.verticalSpace,
                InkWell(
                  onTap: () {
                    CustomDialogs.showBottomSheet(context, DeletReason(
                      onReasonSelected: (reason) {
                        log(reason);
                        setState(() {
                          selectedReason = reason;
                        });
                      },
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      width: 1.sw,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Pallets.white,
                          boxShadow: [
                            BoxShadow(
                                color: Pallets.grey.withOpacity(0.2),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: const Offset(1, 1))
                          ]),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView(
                            text: "Reason for deleting your account",
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Pallets.darkblue,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Pallets.darkblue,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                20.verticalSpace,
                FilledTextField(
                  controller: reasonController,
                  hasElevation: false,
                  fillColor: Pallets.white,
                  hint: "Additional message",
                  maxLine: 6,
                ),
                20.verticalSpace,
                const TextView(
                  text: "Account will be deleted  permanently",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                20.verticalSpace,
                FilledTextField(
                  controller: passwordController,
                  hint: "Enter password",
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'This field is required'),
                    MinLengthValidator(8,
                        errorText: 'Password should be up to 8 characters.')
                  ]).call,
                  obscured: true,
                  hasElevation: false,
                  preffix: const Icon(Iconsax.key),
                  fillColor: Pallets.white,
                ),
                20.verticalSpace,
                BlocConsumer<ProfileBloc, ProfileState>(
                  listener: _listentToDeleteAccountState,
                  bloc: deleteBloc,
                  builder: (context, state) {
                    return CustomButton(
                      onPressed: state is! DeleteAccountLoadingState
                          ? () {
                              deleteUserAccount();
                            }
                          : null,
                      bgColor: Pallets.orange,
                      borderRadius: BorderRadius.circular(25),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: (state is DeleteAccountLoadingState)
                          ? const CircularLoader(
                              size: 20,
                            )
                          : Text('Delete Account'),
                    );
                  },
                ),
                20.verticalSpace,
                OutlinedGoogleButton(
                  onPressed: () {
                    context.goNamed(PageUrl.settings);
                  },
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(25),
                  bgColor: Pallets.normalwhite,
                  child: const TextView(
                    text: "Cancel",
                    style: TextStyle(
                        color: Pallets.darkblue,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                70.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _listentToDeleteAccountState(BuildContext context, ProfileState state) {
    if (state is DeleteAccountLoadingState) {
      log("loading");
    }
    if (state is DeleteAccountSuccessState) {
      CustomDialogs.success("Account Deleted");
      context.goNamed(PageUrl.signIn);
    }
    if (state is DeleteAccountFailureState) {
      CustomDialogs.error(state.error);
      log('error');
    }
  }

  void deleteUserAccount() {
    if (_forkey.currentState!.validate()) {
      deleteBloc.add(AccountDeleteEvent(DeletAccountPayload(
        message: reasonController.text,
        password: passwordController.text,
        reason: selectedReason,
      )));
    }
  }
}
