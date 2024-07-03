import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/utils/extensions/context_extension.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ActiveGameItem extends StatelessWidget {
  const ActiveGameItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.colorScheme.surface),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          ImageWidget(
            imageUrl: Assets.images.jpegs.background.path,
            borderRadius: BorderRadius.circular(3),
          ),
          6.horizontalSpace,
          const Expanded(child: TextView(text: 'Number game')),
          const Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
    );
  }
}
