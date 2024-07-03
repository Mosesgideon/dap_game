import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/core/utils/helper_utils.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialNetwork extends StatefulWidget {
  const SocialNetwork({super.key});

  @override
  State<SocialNetwork> createState() => _SocialNetworkState();
}

class _SocialNetworkState extends State<SocialNetwork> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
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
        children: [
          const TextView(
            text: "Our social networks",
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
          const TextView(
            text: "You can reach us here",
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageWidget(
                imageUrl: Assets.images.pngs.instagram.path,
                size: 20,
                onTap: () {
                  Helpers.launchRawUrl(
                      'https://www.instagram.com/dap_lottery_games?igsh=YTQwZjQ0NmI0OA==');
                },
              ),
              14.horizontalSpace,
              ImageWidget(
                  imageUrl: Assets.images.pngs.twitter.path,
                  size: 20,
                  onTap: () {
                    Helpers.launchRawUrl(
                        'https://www.facebook.com/profile.php?id=61557257203842&mibextid=JRoKGi');
                  }),
              14.horizontalSpace,
              ImageWidget(
                  imageUrl: Assets.images.pngs.fb.path,
                  size: 25,
                  onTap: () {
                    Helpers.launchRawUrl(
                        'https://www.facebook.com/profile.php?id=61557257203842&mibextid=JRoKGi');
                  }),
              14.horizontalSpace,
              ImageWidget(
                  imageUrl: Assets.images.pngs.tiktok.path,
                  size: 20,
                  onTap: () {
                    Helpers.launchRawUrl(
                        'https://www.facebook.com/profile.php?id=61557257203842&mibextid=JRoKGi');
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
