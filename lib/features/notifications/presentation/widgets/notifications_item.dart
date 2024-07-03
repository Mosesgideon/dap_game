import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/features/notifications/data/models/get_notifications_response.dart';
import 'package:dap_game/features/notifications/presentation/bloc/notifications/notifications_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/_core.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';

class NotificationsItem extends StatefulWidget {
  const NotificationsItem({super.key, required this.notification});

  final AppNotification notification;

  @override
  State<NotificationsItem> createState() => _NotificationsItemState();
}

class _NotificationsItemState extends State<NotificationsItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _handleNotificationTap(context);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ImageWidget(
          //   imageUrl: widget.notification.readAt == null
          //       ? Assets.images.svgs.unreadNotification
          //       : Assets.images.svgs.readNotification,
          //   size: 32,
          // ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text:
                      "${widget.notification.data.type.toUpperCase()} NOTIFICATION",
                  style: GoogleFonts.sora(fontSize: 15),
                ),
                10.verticalSpace,
                TextView(
                  text: widget.notification.data.message,
                  color: Pallets.grey35,
                  fontSize: 14,
                ),
                10.verticalSpace,
                TextView(
                  text: TimeUtil.formatOperationsDate(
                      widget.notification.createdAt.toString(), 0),
                  color: Pallets.grey35,
                  fontSize: 14,
                ),
                10.verticalSpace,
                const Divider(),
                25.verticalSpace,
              ],
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_right_sharp,
            size: 30,
          )
        ],
      ),
    );
  }

  void _handleNotificationTap(BuildContext context) {
    widget.notification.readAt = DateTime.now();
    // injector
    //     .get<NotificationsBloc>()
    //     .add(ShowNotificationEvent(id: widget.notification.id));
    setState(() {});

    // if (widget.notification.data.content.dataId != null) {
    switch (widget.notification.data.type) {
      case "payment":
        context.goNamed(PageUrl.wallet, queryParameters: {});
        break;
      // case "invoice":
      //   context.pushNamed(PageUrl.disposalDetails, queryParameters: {
      //     PathParam.id: widget.notification.dataId.toString()
      //   });
      // case "waste":
      //   context.pushNamed(PageUrl.disposalDetails, queryParameters: {
      //     PathParam.id: widget.notification.dataId.toString()
      //   });
      // }
    }
  }
}
