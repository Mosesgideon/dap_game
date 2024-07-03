import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/_core.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/services/data/session_manager.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        decoration: const BoxDecoration(
          color: Pallets.orange,
          // image: DecorationImage(
          //     image: AssetImage(Assets.images.pngs.onboardingbg.path))
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  120.verticalSpace,
                  TextView(
                    text: "Dap\n Games",
                    align: TextAlign.center,
                    style: GoogleFonts.paytoneOne(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w800,
                        color: Pallets.white),
                  ),
                  50.verticalSpace,
                  ImageWidget(
                    imageUrl: Assets.images.pngs.goal.path,
                    size: 200,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                foregroundColor: Pallets.black,
                bgColor: Pallets.white,
                padding: const EdgeInsets.all(16),
                borderRadius: BorderRadius.circular(100.r),
                onPressed: () {
                  SessionManager().hasOnboarded = true;

                  context.goNamed(PageUrl.signUp);
                },
                child: const TextView(
                  text: "Get started",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            16.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                foregroundColor: Pallets.black,
                bgColor: Pallets.white,
                padding: const EdgeInsets.all(16),
                borderRadius: BorderRadius.circular(100.r),
                onPressed: () {
                  SessionManager().hasOnboarded = true;
                  context.goNamed(PageUrl.home);
                },
                child: const TextView(
                  text: "Play",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextView(
                  text: "By continuing you accept our ",
                  style: TextStyle(
                      color: Pallets.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                TextView(
                  onTap: () {
                    UrlLauncher()
                        .launchURL("https://dapgames.com/privacy-policy");
                  },
                  text: "Privacy Policy",
                  style: const TextStyle(
                      color: Pallets.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
