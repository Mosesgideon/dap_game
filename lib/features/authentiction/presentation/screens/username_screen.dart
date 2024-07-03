import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/filled_textfield.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class UserNameInpute extends StatefulWidget {
  const UserNameInpute({super.key});

  @override
  State<UserNameInpute> createState() => _UserNameInputeState();
}

class _UserNameInputeState extends State<UserNameInpute> {
  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: TextView(
                    text: "Let's Set up Your Profile",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Pallets.darkblue,
                  ),
                ),
                20.verticalSpace,
                 Center(child: CircleAvatar(
                  backgroundColor: Pallets.midblue,
                  radius: 50,
                  child: ImageWidget(imageUrl: Assets.images.pngs.profile.path,size: 100,),
                )),
                20.verticalSpace,

                const TextView(
                  text: "Username",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Pallets.darkblue,
                ),
                6.verticalSpace,
                FilledTextField(
                  controller: _usernameController,
                  hint: "username",
                  validator: RequiredValidator(
                    errorText: 'this field is required',
                  ).call,
                ),
                100.verticalSpace,
                CustomButton(
                    bgColor: Pallets.orange,
                    borderRadius: BorderRadius.circular(25),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 18),
                    child: const TextView(
                      text: 'Finish',
                    ),
                    onPressed: () {
                      // _completeGoogleAuth();
                      context.goNamed(PageUrl.home);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _completeGoogleAuth() {
    if (_formKey.currentState!.validate()) {}
  }
}
