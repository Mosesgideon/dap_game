import 'package:dap_game/common/widgets/action_button.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletAppBar extends StatefulWidget {
  const WalletAppBar({super.key});

  @override
  State<WalletAppBar> createState() => _WalletAppBarState();
}

class _WalletAppBarState extends State<WalletAppBar> {
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
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Pallets.primary, width: 1.5),
                imageUrl: injector.get<UserBloc>().appUser?.profilePhoto ?? '',
                size: 40,
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
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: Pallets.primary,
                          ),
                        ),
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

                ],
              ),
            ),
            CustomActionButton(
              size: 40,
              child: const Icon(
                Icons.notifications_outlined,
                color: Pallets.white,
              ),
              onTap: () {},
            ),
            10.horizontalSpace,
            CustomActionButton(
              size: 40,
              child: const Icon(
                Icons.notifications_outlined,
                color: Pallets.white,
              ),
              onTap: () {},
            )
          ],
        );
      },
    );
  }
}
