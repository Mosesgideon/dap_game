import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/error_widget.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/info_dialog.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/_core.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/services/data/session_manager.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:dap_game/features/profile/presentation/widgets/profile_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  // final profilebloc = ProfileBloc(injector.get());
  final userBloc = injector.get<UserBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const TextView(
          text: "Profile",
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Pallets.black,
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<UserBloc, UserState>(
        bloc: injector.get(),
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (injector.get<UserBloc>().appUser != null) {
            return Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      40.verticalSpace,
                      ImageWidget(
                        imageUrl:
                            injector.get<UserBloc>().appUser?.profilePhoto ??
                                "",
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Pallets.primary, width: 1.5),
                        size: 100,
                      ),
                      10.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextView(
                            text: injector.get<UserBloc>().appUser?.firstname ??
                                "",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          4.horizontalSpace,
                          TextView(
                            text: injector.get<UserBloc>().appUser?.lastname ??
                                "",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      TextView(
                        text: injector.get<UserBloc>().appUser?.username ?? "",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      49.verticalSpace,
                      ProfileSettingItem(
                        voidCallback: () {
                          context.pushNamed(PageUrl.personal_details);
                        },
                        title: 'Account',
                        subtitle: 'See your account details',
                      ),
                      16.verticalSpace,
                      ProfileSettingItem(
                        title: 'Security',
                        subtitle: 'Security/Password Reset Settings',
                        voidCallback: () {
                          context.pushNamed(PageUrl.securityscreen);
                        },
                      ),
                      16.verticalSpace,
                      ProfileSettingItem(
                        title: 'Notifications',
                        subtitle: 'Notification Settings',
                        voidCallback: () {
                          context.pushNamed(PageUrl.notificationsSettingScreen);
                        },
                      ),
                      16.verticalSpace,
                      ProfileSettingItem(
                        title: 'Support Center',
                        subtitle: 'We are here to assist you.',
                        voidCallback: () {
                          context.pushNamed(PageUrl.support_center);
                        },
                      ),
                      16.verticalSpace,
                      ProfileSettingItem(
                        title: 'Privacy Policy',
                        subtitle: '',
                        voidCallback: () {
                          UrlLauncher()
                              .launchURL("https://dapgames.com/privacy-policy");
                        },
                      ),
                      16.verticalSpace,
                      ProfileSettingItem(
                        title: 'Delete Account',
                        subtitle: 'Permanently Delete My Account',
                        voidCallback: () {
                          context.pushNamed(PageUrl.delete_account);
                        },
                      ),
                      60.verticalSpace,
                      CustomButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
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
                          }),
                      100.verticalSpace,
                    ],
                  ),
                ));
          }

          return AppPromptWidget(
            title: 'Sign in to continue',
            message: 'Please sign in or register to create a profile',
            retryText: 'Sign in',
            onTap: () {
              context.pushNamed(PageUrl.signIn);
            },
          );
        },
      ),
    );
  }

  void _logout(BuildContext context) async {
    //to  logout
    SessionManager().logOut();
    CustomDialogs.showCustomDialog(
        barrierDismissible: false,
         InfoDialog(
          footer: Padding(
            padding: const EdgeInsets.all(16.0),
            child: 0.horizontalSpace,
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
