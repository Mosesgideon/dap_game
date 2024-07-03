import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class FundSuccess extends StatefulWidget {
  const FundSuccess({super.key});

  @override
  State<FundSuccess> createState() => _FundSuccessState();
}

class _FundSuccessState extends State<FundSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ImageWidget(
                imageUrl: Assets.images.pngs.fundSuccess.path,
                size: 200,
              ),
            ),
            25.verticalSpace,
            const TextView(
              text: "Payment was successful",
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            50.verticalSpace,
            CustomButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                borderRadius: BorderRadius.circular(25),
                bgColor: Pallets.orange,
                child: const TextView(
                  text: "Continue",
                ),
                onPressed: () {
                  context.goNamed(PageUrl.wallet);
                }),
          ],
        ),
      ),
    );
  }
}
