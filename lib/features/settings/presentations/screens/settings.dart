import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/info_dialog.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/services/data/session_manager.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/settings/presentations/widgets/settings_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const TextView(
          text: "Settings",
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Pallets.black,
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Pallets.darkblue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsItems(
                title: 'Security',
                subtitle: 'Security/Password Reset Settings',
                voidCallback: () {
                  context.pushNamed(PageUrl.securityscreen);
                },
              ),
              SettingsItems(
                title: 'Notifications',
                subtitle: 'Notification Settings',
                voidCallback: () {
                  context.pushNamed(PageUrl.notificationsSettingScreen);

              },
            ),
            // SettingsItems(
            //   title: 'FAQ',
            //   subtitle: 'check out som questions',
            //   voidCallback: () {
            //     // context.pushNamed(PageUrl.faq);
            //     },
            //   ),
              SettingsItems(
                title: 'Support Center',
                subtitle: 'We are here to assist you.',
                voidCallback: () {
                  context.pushNamed(PageUrl.support_center);

                },
              ),
              SettingsItems(
                title: 'Delete Account',
                subtitle: 'Permanently Delete My Account',
                voidCallback: () {
                  context.pushNamed(PageUrl.delete_account);

                },
              ),
              60.verticalSpace,
              CustomButton(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                bgColor: Pallets.darkblue,
                  borderRadius: BorderRadius.circular(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Iconsax.logout),
                      10.horizontalSpace,
                      const TextView(
                        text: "Log Out",
                      ),
                    ],
                  ),
                  onPressed: () {
                    _logout(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
  void _logout(BuildContext context) async {
    //to  logout
    SessionManager().logOut();
    CustomDialogs.showCustomDialog(
        barrierDismissible: false,
        const InfoDialog(
                footer: Padding(
            padding: EdgeInsets.all(16.0),
            child: SpinKitFadingCircle(
              size: 50,
              color: Pallets.mildBlue,
            ),
          ),
          tittle: "Signing Out",
          subtittle:
          "You will be redirected to the login page in a few seconds",
        ),
        context);
    Future.delayed(
      const Duration(
        seconds: 3,

      ),
          () {
        context.goNamed(PageUrl.signIn);
      },
    );


  }
}
