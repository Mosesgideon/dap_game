import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/settings/presentations/widgets/notificationitem.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
class PushNotification extends StatefulWidget {
  const PushNotification({super.key});

  @override
  State<PushNotification> createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  bool val=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const TextView(
          text: "Push Notification",
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Pallets.black,
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Iconsax.arrow_left,
            color: Pallets.darkblue,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationItems(
              voidCallback: () {},
              title: 'Dap game activity',
              widget: Switch(
                value: val,
                onChanged: (bool value) {},
              ),
            ),

          ],
        ),
      ),
    );
  }
}
