import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:flutter/material.dart';

class NotificationItems extends StatefulWidget {
  final VoidCallback voidCallback;
  final String title;
  final String subtitle;
  final Widget? widget;

  const NotificationItems(
      {super.key,
      required this.voidCallback,
      required this.title,
      this.subtitle="",
      this.widget});

  @override
  State<NotificationItems> createState() => _NotificationItemsState();
}

class _NotificationItemsState extends State<NotificationItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: widget.voidCallback,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          width: 1.sw,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
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
              TextView(
                text: widget.title,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Pallets.darkblue,
              ),

             Row(
               children: [
                 TextView(
                   text: widget.subtitle,
                   fontSize: 17,
                   fontWeight: FontWeight.w600,
                   color: Pallets.darkblue,
                 ),
                 10.horizontalSpace,
                 widget.widget ??
                     const Icon(
                       Icons.arrow_forward_ios_rounded,
                       color: Pallets.darkblue,
                       size: 20,
                     )
               ],
             )
            ],
          ),
        ),
      ),
    );
  }
}
