import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/profile/presentation/screens/change_password_screen.dart';
import 'package:dap_game/features/settings/presentations/widgets/settings_items.dart';
import 'package:flutter/material.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool val = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const TextView(
          text: "Security Settings",
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
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsItems(
              title: 'Reset Password',
              subtitle: 'Security/Password Reset Settings',
              voidCallback: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen(),
                    ));
              },
            ),
            SettingsItems(
              title: 'Enable Biometric',
              subtitle: 'Activate Facial/Finger Print',
              voidCallback: () {},
              widget: SizedBox(
                height: 30,
                width: 60,
                child: Switch(
                  value: val,
                  onChanged: (bool value) {},
                  activeColor: Pallets.darkblue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
