import 'package:dap_game/features/notifications/presentation/bloc/notifications/notifications_bloc.dart';
import 'package:dap_game/features/notifications/presentation/widgets/notifications_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dap_game/common/widgets/app_empty_state.dart';
import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/error_widget.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/theme/pallets.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    injector.get<NotificationsBloc>().add(GetNotificationsEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittleText: 'Notification',
        actions: [
          PopupMenuButton(
            position: PopupMenuPosition.over,
            // constraints: const BoxConstraints(maxHeight: 60,),
            constraints: const BoxConstraints(maxWidth: 200),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
            onSelected: (value) {
              switch (value) {
                case "read_all":
                  injector
                      .get<NotificationsBloc>()
                      .add(const MarkAllAsReadEvent());
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<String>(
                  value: 'read_all',
                  height: 30,
                  child: Text(
                    'Mark all as read',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ];
            },
            child: const CircleAvatar(
                backgroundColor: Pallets.white,
                foregroundColor: Pallets.black,
                child: Icon(Icons.more_vert)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<NotificationsBloc, NotificationState>(
          bloc: injector.get(),
          buildWhen: _buildWhen,
          listener: _listenToNotificationBloc,
          builder: (context, state) {
            if (state is GetNotificationsLoadingState) {
              return Center(
                child: CustomDialogs.getLoading(size: 30),
              );
            }

            if (state is GetNotificationsFailureState) {
              return Center(
                child: AppPromptWidget(
                  // canTryAgain: false,
                  onTap: () {
                    injector
                        .get<NotificationsBloc>()
                        .add(GetNotificationsEvent());
                  },
                ),
              );
            }

            if (state is GetNotificationsSuccessState) {
              return Column(
                children: [
                  if (state.response.data.notifications.isNotEmpty)
                    //   const CustomSearchBar(
                    //     tittle: 'Search',
                    //   ),
                    // 28.verticalSpace,
                    Expanded(
                        child: RefreshIndicator(
                      onRefresh: () async {
                        injector
                            .get<NotificationsBloc>()
                            .add(GetNotificationsEvent());
                      },
                      child: state.response.data.notifications.isNotEmpty
                          ? ListView.builder(
                              itemCount:
                                  state.response.data.notifications.length,
                              itemBuilder: (context, index) =>
                                  NotificationsItem(
                                notification:
                                    state.response.data.notifications[index],
                              ),
                            )
                          : AppEmptyWidget(
                              onRefresh: () {
                                injector
                                    .get<NotificationsBloc>()
                                    .add(GetNotificationsEvent());
                              },
                              onButtonClick: () {},
                              buttonText: '',
                              tittle: 'No notifications here',
                              hasButton: false,
                              subtitle:
                                  'You have no notifications here they will appear here if any.',
                            ),
                    )),
                  // FilledTextField(hint: '')
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  void _listenToNotificationBloc(
      BuildContext context, NotificationState state) {
    if (state is ReadAllNotificationsLoading) {
      CustomDialogs.showLoading(context);
    }

    if (state is ReadAllNotificationsFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }

    if (state is ReadAllNotificationsSuccessState) {
      context.pop();
      CustomDialogs.success('Notifications marked as read');
      injector.get<NotificationsBloc>().add(GetNotificationsEvent());
    }
  }

  bool _buildWhen(NotificationState previous, NotificationState current) {
    return current is GetNotificationsLoadingState ||
        current is GetNotificationsSuccessState ||
        current is GetNotificationsFailureState;
  }
}
