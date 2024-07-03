import 'package:dap_game/common/widgets/action_button.dart';
import 'package:dap_game/common/widgets/error_widget.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:dap_game/features/wallets/presentation/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:dap_game/features/wallets/presentation/widgets/transactions.dart';
import 'package:dap_game/features/wallets/presentation/widgets/wallet_card.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletsTab extends StatefulWidget {
  const WalletsTab({super.key});

  @override
  State<WalletsTab> createState() => _WalletsTabState();
}

class _WalletsTabState extends State<WalletsTab> {

  final profileBloc = ProfileBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<UserBloc, UserState>(
          bloc: injector.get(),
          listener: (context, state) {},
          builder: (context, state) {
            if (injector
                .get<UserBloc>()
                .appUser != null) {
              return Column(
                children: [
                  10.verticalSpace,
                  Expanded(
                      child: SingleChildScrollView(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            injector.get<WalletBloc>().add(
                                GetWalletDetailsEvent());
                            profileBloc.add(GetProfileEvent());
                          },
                          child: Column(
                            children: [
                              18.verticalSpace,
                              const WalletCard(),
                              20.verticalSpace,
                              const Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  TextView(
                                    text: "Transactions",

                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  // CustomActionButton(
                                  //   size: 40,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: ImageWidget(
                                  //         imageUrl: Assets.images.pngs.filter.path),
                                  //   ),
                                  //   onTap: () {},
                                  // ),
                                ],
                              ),
                              20.verticalSpace,
                              const Transactions(),
                            ],
                          ),
                        ),
                      ))
                ],
              );
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
      ),
    );
  }
}
