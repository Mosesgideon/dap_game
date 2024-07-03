import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeResultCard extends StatelessWidget {
  const HomeResultCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallets.buttonGrey,
        borderRadius: BorderRadius.circular(16),
        // image: DecorationImage(image: AssetImage(Assets.images.jpegs.orangeBg.path,),fit: BoxFit.cover),

        // gradient: const LinearGradient(colors: [
        //   Color(0xFFEF673F),
        //   Color(0xFFEF673F),
        //   // Color(0xFFB12800),
        // ])
      ),
      width: 1.sw,
      // height: 100,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Pallets.primary,
                        foregroundColor: Pallets.white),
                    onPressed: () {},
                    child: TextView(
                      text: 'DAP GAME',
                      style: GoogleFonts.sora(fontWeight: FontWeight.w600),
                    )),
                10.verticalSpace,
                TextView(
                  text: 'Ready for some thrills?',
                  style: GoogleFonts.sora(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      height: 1.5,
                      color: Pallets.primary),
                ),
                TextView(
                  text: 'Try your luck with our exciting games!',
                  style: GoogleFonts.sora(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      height: 1.5,
                      color: Pallets.primary),
                ),
                // 16.verticalSpace,
                // Row(
                //   children: [
                //     const Icon(
                //       Icons.person_2_rounded,
                //       color: Pallets.grey,
                //       size: 18,
                //     ),
                //     5.horizontalSpace,
                //     const TextView(
                //       text: '500 Winners',
                //       // fontWeight: FontWeight.w600,
                //       fontSize: 13,
                //     ),
                //     10.horizontalSpace,
                //     ImageWidget(
                //       imageUrl: Assets.images.svgs.resultsFilled,
                //       color: Pallets.grey,
                //       size: 18,
                //     ),
                //     5.horizontalSpace,
                //     const TextView(
                //       text: '20 Selections',
                //       fontSize: 13,
                //       // fontWeight: FontWeight.w600,
                //       color: Pallets.grey,
                //     ),
                //   ],
                // )
              ],
            ),
          ),
          ImageWidget(
            imageUrl: Assets.images.pngs.coins.path,
            size: 100,
          )
        ],
      ),
    );
  }
}
