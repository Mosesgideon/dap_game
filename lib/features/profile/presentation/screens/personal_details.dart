import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/services/data/session_manager.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:dap_game/features/profile/presentation/widgets/profileList.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final profilebloc = ProfileBloc(injector.get());
  final userBloc = injector.get<UserBloc>();

  @override
  void initState() {
    if (SessionManager.instance.isLoggedIn) {
      profilebloc.add(GetProfileEvent());
    }
    super.initState();
  }

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
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Pallets.primary,
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: const BorderSide(color: Pallets.darkblue)))),
                onPressed: () {
                  context.pushNamed(PageUrl.details_edit);
                },
                child: const TextView(text: "Edit"),
              ))
        ],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: _listenToUserState,
        bloc: userBloc,
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(clipBehavior: Clip.none, children: [
                      ImageWidget(
                        width: 1.sw,
                        color: Pallets.darkblue,
                        height: 100,
                        imageUrl: userBloc.appUser?.coverPhoto ??
                            Assets.images.pngs.back.path,
                      ),
                      Positioned(
                        bottom: -35,
                        left: 10,
                        child: ImageWidget(
                            shape: BoxShape.circle,
                            size: 100,
                            border:
                                Border.all(width: 2, color: Pallets.primary),
                            imageUrl: userBloc.appUser?.profilePhoto ??
                                Assets.images.pngs.profile.path),
                      ),
                    ]),
                    70.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          ProfileItem(
                            voidCallback: () {},
                            title: 'First Name',
                            subtitle: userBloc.appUser?.firstname ?? '',
                          ),
                          4.verticalSpace,
                          ProfileItem(
                            voidCallback: () {},
                            title: 'Last Name',
                            subtitle: userBloc.appUser?.lastname ?? '',
                          ),
                          4.verticalSpace,
                          ProfileItem(
                            voidCallback: () {},
                            title: 'UserName',
                            subtitle: userBloc.appUser?.username ?? '',
                          ),
                          4.verticalSpace,
                          ProfileItem(
                            voidCallback: () {},
                            title: 'Email',
                            subtitle: userBloc.appUser?.email ?? '',
                          ),
                          4.verticalSpace,
                          ProfileItem(
                            voidCallback: () {},
                            title: 'Phone Number',
                            subtitle: userBloc.appUser?.phone ?? "",
                          ),
                          4.verticalSpace,
                          ProfileItem(
                            voidCallback: () {},
                            title: 'Country',
                            subtitle: userBloc.appUser?.country ?? "",
                          ),
                          4.verticalSpace,
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }

  void _listenToUserState(BuildContext context, UserState state) {}
}
