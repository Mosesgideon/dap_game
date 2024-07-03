import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/settings/presentations/widgets/notificationitem.dart';
import 'package:flutter/material.dart';

class NotificationsSettingScreen extends StatefulWidget {
  const NotificationsSettingScreen({super.key});

  @override
  State<NotificationsSettingScreen> createState() => _NotificationsSettingScreenState();
}

class _NotificationsSettingScreenState extends State<NotificationsSettingScreen> {
  bool emailEnabled = false;
  bool smsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const TextView(
          text: "Notification Settings",
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Pallets.black,
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Pallets.darkblue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // NotificationItems(
            //   voidCallback: () {},
            //   title: 'Push',
            //   subtitle: "Some enabled",
            // ),
            NotificationItems(
              voidCallback: () {},
              title: 'SMS',
              widget: SizedBox(
                height: 20,
                child: Switch(
                  activeColor: Pallets.primary,
                  value: smsEnabled,
                  onChanged: (bool value) {
                    smsEnabled = !smsEnabled;
                    setState(() {});
                  },
                ),
              ),
            ),
            NotificationItems(
              voidCallback: () {},
              title: 'Email',
              widget: SizedBox(
                height: 20,
                child: Switch(
                  activeColor: Pallets.primary,
                  value: emailEnabled,
                  onChanged: (bool value) {
                    emailEnabled = !emailEnabled;
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
