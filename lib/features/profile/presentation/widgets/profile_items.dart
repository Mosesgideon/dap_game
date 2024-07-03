import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:flutter/material.dart';

class ProfileSettingItem extends StatelessWidget {
  final VoidCallback voidCallback;
  final String title;
  final String subtitle;

  const ProfileSettingItem(
      {super.key,
      required this.voidCallback,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: voidCallback,
      child: Container(
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: title,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Pallets.darkblue,
                    ),
                    // TextView(
                    //   text: subtitle,
                    //   fontSize: 14,
                    //   fontWeight: FontWeight.w400,
                    //   color: Pallets.grey,
                    // ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
