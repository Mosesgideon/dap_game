import 'package:dap_game/common/widgets/custom_checkbox.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:flutter/material.dart';

class WithdrawalResetMethod extends StatefulWidget {
  const WithdrawalResetMethod(
      {super.key,
        required this.checked,
        required this.onTap,
        required this.icon,
        required this.title,
        required this.subtitle});

  final bool checked;
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  State<WithdrawalResetMethod> createState() => _WithdrawalResetMethodState();
}

class _WithdrawalResetMethodState extends State<WithdrawalResetMethod> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: widget.checked ? Border.all(color: Pallets.darkblue) : null,
            color: Pallets.white,
            boxShadow: const [
              BoxShadow(
                  color: Pallets.lightGrey,
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(0.5, 0.5))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(widget.icon,
                        color: widget.checked?Pallets.darkblue:Pallets.grey
                    ),
                    5.horizontalSpace,
                    TextView(
                      text: widget.title,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                        color: widget.checked?Pallets.darkblue:Pallets.grey

                    )
                  ],
                ),
                6.verticalSpace,
                TextView(
                  text:
                  widget.subtitle,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                    color: widget.checked?Pallets.darkblue:Pallets.grey

                )
              ],
            ),
            CustomCheckBox(
              onChecked: (bool val) {
                widget.onTap();
                setState(() {});
              },
              value: widget.checked,
            )
          ],
        ),
      ),
    );
  }
}