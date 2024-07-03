import 'package:dap_game/common/widgets/action_button.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/core/utils/string_extension.dart';
import 'package:dap_game/features/leaderboard/presentations/screens/leaderboard.dart';
import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeApBar extends StatefulWidget {
  const HomeApBar({super.key});

  @override
  State<HomeApBar> createState() => _HomeApBarState();
}

class _HomeApBarState extends State<HomeApBar> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      bloc: injector.get(),
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          children: [
            if (injector.get<UserBloc>().appUser != null)
              ImageWidget(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Pallets.secondary, width: 1.5),
                imageUrl: injector.get<UserBloc>().appUser?.profilePhoto ?? '',
                size: 50,
              ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (injector.get<UserBloc>().appUser != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: 'My Account',
                          style: GoogleFonts.sora(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: Pallets.primary,
                          ),
                        ),
                        4.verticalSpace,
                        TextView(
                          text: injector
                                  .get<UserBloc>()
                                  .appUser
                                  ?.wallet
                                  .balance ??
                              '',
                          style: GoogleFonts.sora(
                            fontWeight: FontWeight.w700,
                            color: Pallets.primary,
                          ),
                        )
                      ],
                    ),
                  if (injector.get<UserBloc>().appUser == null)
                    TextButton(
                        onPressed: () {
                          context.pushNamed(PageUrl.signIn);
                        },
                        child: TextView(
                          text: 'Register/Signin',
                          style: GoogleFonts.sora(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ))
                ],
              ),
            ),
            CustomActionButton(
              size: 40,
              child: const Icon(
                Icons.notifications_outlined,
                color: Pallets.white,
              ),
              onTap: () {
                context.pushNamed(PageUrl.notificationsScreen);
              },
            )
          ],
        );
      },
    );
  }
}
