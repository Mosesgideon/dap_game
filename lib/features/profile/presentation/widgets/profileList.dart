import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final VoidCallback voidCallback;
  final String title;
  final String subtitle;

  const ProfileItem(
      {super.key,
      required this.voidCallback,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: voidCallback,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: title,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Pallets.darkblue,
              ),
              6.verticalSpace,
              Row(
                children: [
                  20.horizontalSpace,
                  TextView(
                    text: subtitle,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Pallets.darkblue,
                  ),
                ],
              ),
            ],
          ),
        ),
        18.verticalSpace,
        const Divider(
          color: Pallets.grey,
        )
      ],
    );
  }
}
