import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
class FaqWidget extends StatelessWidget {
  const FaqWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(PageUrl.faq);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Pallets.white,
            boxShadow: const [
              BoxShadow(
                  color: Pallets.grey90,
                  spreadRadius: 0.5,
                  blurRadius: 1),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                10.horizontalSpace,
                 ImageWidget(
                  imageUrl: Assets.images.pngs.faq.path,
                  size: 17,
                ),
                13.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextView(
                      text: "Faq",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    2.verticalSpace,
                    const TextView(
                      text: "Answers to all question",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 17,
            )
          ],
        ),
      ),
    );
  }
}
