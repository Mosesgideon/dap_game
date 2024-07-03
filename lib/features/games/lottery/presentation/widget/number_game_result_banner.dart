import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/neumorphic_button.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/path_params.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LotteryGameResultBanner extends StatelessWidget {
  const LotteryGameResultBanner({super.key, required this.gameId});

  final String gameId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Pallets.buttonGrey,
        image: DecorationImage(
            image: AssetImage(
              Assets.images.jpegs.blueBg.path,
            ),
            fit: BoxFit.cover),
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
                    onPressed: () {

                    },
                    child: TextView(
                      text: '200+ Draws',
                      style: GoogleFonts.sora(fontWeight: FontWeight.w600),
                    )),
                4.verticalSpace,
                TextView(
                  text: 'Up to \$20,000 Won in a\ntotal of 100 games',
                  style: GoogleFonts.sora(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      height: 1.5,
                      color: Pallets.white),
                ),
                8.verticalSpace,
                CustomNeumorphicButton(
                  onTap: () {
                    context.pushNamed(PageUrl.selectDrawScreen,
                        queryParameters: {PathParam.id: gameId});
                  },
                  color: Pallets.white,
                  expanded: false,
                  padding: const EdgeInsets.all(5),
                  fgColor: Pallets.primary,
                  text: 'View all results',
                )
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
