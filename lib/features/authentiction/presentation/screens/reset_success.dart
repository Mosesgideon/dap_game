import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ResetSuccess extends StatefulWidget {
  const ResetSuccess({super.key});

  @override
  State<ResetSuccess> createState() => _ResetSuccessState();
}

class _ResetSuccessState extends State<ResetSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
            onTap: () {
              context.pushNamed(PageUrl.signIn);
            },
            child: const Icon(
              Iconsax.arrow_left,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            40.verticalSpace,
            ImageWidget(
              imageUrl: Assets.images.pngs.resetsuccess.path,
              size: 300,
            ),
            49.verticalSpace,
            const TextView(
              text: "Password Reset",
              style: TextStyle(
                  color: Pallets.darkblue,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const TextView(
              text: "Your password has been reset successfully",
              style: TextStyle(
                  color: Pallets.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w300),
            ),
            48.verticalSpace,
            CustomButton(
              onPressed: () {
                context.pushNamed(PageUrl.signIn);
              },
              bgColor: Pallets.orange,
              borderRadius: BorderRadius.circular(25),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
              child: const TextView(
                text: "Continue Playing",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
