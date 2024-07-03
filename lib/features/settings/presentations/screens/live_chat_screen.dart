import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class LiveChatScreen extends StatefulWidget {
  const LiveChatScreen({super.key});

  @override
  State<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        tittleText: "Live chat",
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              50.verticalSpace,
              ImageWidget(
                imageUrl: Assets.images.pngs.support.path,
                height: 200.h,
                width: 100.w,
              ),
              20.verticalSpace,
              const TextView(
                align: TextAlign.center,
                text:
                    "No support agent available at the moment, kindly reach out later or send us a message",
                color: Pallets.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              20.verticalSpace,
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(
                    padding: const EdgeInsets.all(16),
                    onPressed: () {
                      context.pushReplacementNamed(PageUrl.reportProblem);
                    },
                    child: const TextView(text: "Send us a message")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
