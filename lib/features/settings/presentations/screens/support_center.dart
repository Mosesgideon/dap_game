import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/profile/presentation/widgets/profile_items.dart';
import 'package:dap_game/features/settings/presentations/widgets/contactWidget.dart';
import 'package:dap_game/features/settings/presentations/widgets/faqwidget.dart';
import 'package:dap_game/features/settings/presentations/widgets/social_network.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SupportCenter extends StatefulWidget {
  const SupportCenter({super.key});

  @override
  State<SupportCenter> createState() => _SupportCenterState();
}

class _SupportCenterState extends State<SupportCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallets.primary,
        foregroundColor: Pallets.white,
        onPressed: () {
          context.pushNamed(PageUrl.liveChat);

        },
        child: const Icon(Iconsax.message),
      ),
      appBar: const CustomAppBar(
        tittle: TextView(
          text: "Support Center",
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextView(
                text: "Need Help?",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              5.verticalSpace,
              const TextView(
                text: "We are here to assist you.",
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              15.verticalSpace,
              const FaqWidget(),
              20.verticalSpace,
              ProfileSettingItem(
                title: 'Report a problem',
                subtitle: '',
                voidCallback: () {
                  context.pushNamed(PageUrl.reportProblem);
                },
              ),
              20.verticalSpace,
              const TextView(
                text: "Contacts",
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Pallets.primary,
              ),
              16.verticalSpace,
              const ContactWidget(),
              20.verticalSpace,
              const TextView(
                text: "Address",
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Pallets.primary,
              ),
              16.verticalSpace,
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Pallets.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Pallets.grey90,
                          spreadRadius: 0.5,
                          blurRadius: 1),
                    ]),
                child: const TextView(
                    color: Pallets.primary,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    text:
                        "91 ST. PATRICK CHURCH UMUERIM, NEKEDE ROAD., OWERRI, IMO STATE, Nigeria"),
              ),
              35.verticalSpace,
              ImageWidget(
                imageUrl: Assets.images.pngs.customercare.path,
                width: 1.sw,
                height: 100,
                borderRadius: BorderRadius.circular(10),
              ),
              45.verticalSpace,
              const SocialNetwork()
            ],
          ),
        ),
      ),
    );
  }
}
