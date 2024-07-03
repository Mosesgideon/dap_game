import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:flutter/material.dart';

class SettingsItems extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback voidCallback;
  final Widget? widget;

  const SettingsItems(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.voidCallback,
      this.widget});

  @override
  State<SettingsItems> createState() => _SettingsItemsState();
}

class _SettingsItemsState extends State<SettingsItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: widget.voidCallback,
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
          width: 1.sw,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Pallets.white,
              boxShadow: [
                BoxShadow(
                    color: Pallets.grey.withOpacity(0.2),
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: const Offset(1, 1))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: widget.title,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Pallets.darkblue,
                  ),
                  6.verticalSpace,
                  TextView(
                    text: widget.subtitle,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Pallets.grey,
                  )
                ],
              ),
              widget.widget ??
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Pallets.darkblue,
                    size: 20,
                  )
            ],
          ),
        ),
      ),
    );
  }
}
