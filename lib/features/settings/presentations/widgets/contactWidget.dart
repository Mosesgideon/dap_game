import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/core/utils/url_launcher.dart';
import 'package:flutter/material.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Pallets.white,
          boxShadow: const [
            BoxShadow(color: Pallets.grey90, spreadRadius: 0.5, blurRadius: 1),
          ]),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              UrlLauncher().dialPhoneNumber("+234 706 530 9748");
            },
            child: Row(
              children: [
                const Icon(
                  Icons.phone_android_outlined,
                  color: Pallets.secondary,
                ),
                8.horizontalSpace,
                const TextView(
                  text: "+234 706 530 9748",
                  color: Pallets.primary,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
          ),
          20.verticalSpace,
          // InkWell(
          //   onTap: () {
          //     UrlLauncher().dialPhoneNumber("+(443) 272-1685");
          //   },
          //   child: Row(
          //     children: [
          //       const Icon(
          //         Icons.phone_android_outlined,
          //         color: Pallets.secondary,
          //       ),
          //       8.horizontalSpace,
          //       const TextView(
          //         text: "+(443) 272-1685",
          //         color: Pallets.primary,
          //         fontSize: 17,
          //         fontWeight: FontWeight.w600,
          //       )
          //     ],
          //   ),
          // ),
          // 20.verticalSpace,
          InkWell(
            onTap: () {
              UrlLauncher().sendEmail("support@dapgames.com");
            },
            child: Row(
              children: [
                const Icon(
                  Icons.email_outlined,
                  color: Pallets.secondary,
                ),
                8.horizontalSpace,
                const TextView(
                  text: "support@dapgames.com",
                  color: Pallets.primary,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
