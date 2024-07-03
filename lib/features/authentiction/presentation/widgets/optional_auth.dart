import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
class OptionAuthSignInMethod extends StatefulWidget {
  const OptionAuthSignInMethod({super.key});

  @override
  State<OptionAuthSignInMethod> createState() => _OptionAuthSignInMethodState();
}

class _OptionAuthSignInMethodState extends State<OptionAuthSignInMethod> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         ImageWidget(imageUrl:  Assets.images.pngs.apple.path),
         24.horizontalSpace,
         ImageWidget(imageUrl:  Assets.images.pngs.facebook.path),
          24.horizontalSpace,
         ImageWidget(imageUrl:  Assets.images.pngs.google.path),

        ],
      ),
    );
  }
}
