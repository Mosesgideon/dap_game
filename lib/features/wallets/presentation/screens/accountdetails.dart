import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
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
            Icons.arrow_back_ios_new,
            color: Pallets.primary,
          ),
        ),
        title: const Text(
          "Account Details",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Pallets.primary),
        ),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        bloc: injector.get(),
        listener: listenToUserState,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageWidget(imageUrl: Assets.images.pngs.nigeria.path),
                        20.horizontalSpace,
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              text: "\$",
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Pallets.darkblue,
                            ),
                            TextView(
                              text: "Nigerian \$",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Pallets.grey,
                            )
                          ],
                        ),
                      ],
                    ),
                    TextView(
                      text:
                          "\$${injector.get<UserBloc>().appUser?.wallet.balance}",
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Pallets.darkblue,
                    )
                  ],
                ),
                20.verticalSpace,
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            text: "Account Name",
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Pallets.darkblue,
                          ),
                          6.verticalSpace,
                          Row(
                            children: [
                              TextView(
                                text:
                                    injector.get<UserBloc>().appUser!.firstname,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Pallets.grey,
                              ),
                              5.horizontalSpace,
                              TextView(
                                text:
                                    injector.get<UserBloc>().appUser!.lastname,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Pallets.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                      30.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextView(
                                text: "Referral ID",
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Pallets.darkblue,
                              ),
                              6.verticalSpace,
                              Row(
                                children: [
                                  TextView(
                                    text: injector
                                        .get<UserBloc>()
                                        .appUser!
                                        .referralId,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Pallets.grey,
                                  ),
                                  5.horizontalSpace,
                                  InkWell(
                                    onTap: () {
                                      CustomDialogs.success(
                                          "Copied to clipboard");
                                    },
                                    child: const Icon(
                                      Icons.copy_rounded,
                                      size: 18,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                side: MaterialStateProperty.all(
                                  const BorderSide(
                                    color: Pallets.darkblue,
                                  ),
                                )),
                            child: const Text("Share"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                20.verticalSpace,
                const TextView(
                  text:
                      "Use your referral to invite friends and get referral bonus when they play a game.",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Pallets.darkblue,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void listenToUserState(BuildContext context, UserState state) {}
}
