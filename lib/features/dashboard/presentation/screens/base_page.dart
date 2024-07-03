import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:google_fonts/google_fonts.dart';

final GlobalKey<ScaffoldState> baseScaffoldKey = GlobalKey<ScaffoldState>();

class BasePage extends StatefulWidget {
  const BasePage({
    super.key,
    this.passedIndex = 0,
    required this.navigationShell,
  });

  final int passedIndex;

  final StatefulNavigationShell navigationShell;

  @override
  State createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> with WidgetsBindingObserver {
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    logger.i("APP STATE: $state");

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;
  }

  void _goBranch(int index) {
    // if (index != 1) {
    // context.goNamed(PageUrl.signUp);
    // SessionManager.instance.logOut();
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: baseScaffoldKey,
      extendBody: true,
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.navigationShell.currentIndex,
        onTap: _goBranch,
        elevation: 0,
        unselectedItemColor: Pallets.grey35,
        selectedItemColor: Pallets.primary,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        selectedLabelStyle: GoogleFonts.poppins(
            color: Pallets.primary, fontSize: 15, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 14,
        ),
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: ImageWidget(
                imageUrl: Assets.images.svgs.homeFilled,
                size: 30.w,
                color: Pallets.grey35),
            activeIcon: ImageWidget(
                imageUrl: Assets.images.svgs.homeFilled, size: 30.w),
          ),
          BottomNavigationBarItem(
            label: 'Games',
            icon: ImageWidget(
                imageUrl: Assets.images.svgs.game,
                size: 30.w,
                color: Pallets.grey35),
            activeIcon: ImageWidget(
              imageUrl: Assets.images.svgs.game,
              size: 30.w,
              color: Pallets.primary,
            ),
          ),
          // BottomNavigationBarItem(
          //   label: 'Results',
          //   icon: ImageWidget(imageUrl: Assets.images.svgs.results, size: 25.w),
          //   activeIcon: ImageWidget(
          //     imageUrl: Assets.images.svgs.resultsFilled,
          //     size: 27.w,
          //     color: Pallets.primary,
          //   ),
          //   // activeIcon: ImageWidget(
          //   //     imageUrl: Assets.svgsLinkSelected, size: 58.w),
          // ),
          BottomNavigationBarItem(
            label: 'Wallet',
            icon: ImageWidget(
                imageUrl: Assets.images.svgs.wallet,
                color: Pallets.grey35,
                size: 30.w),
            activeIcon: ImageWidget(
              imageUrl: Assets.images.svgs.wallet,
              size: 30.w,
              color: Pallets.primary,
            ),
            // activeIcon: ImageWidget(
            //     imageUrl: Assets.svgsChatSelected, size: 58.w),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: IgnorePointer(
              ignoring: true,
              child: ImageWidget(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Pallets.secondary, width: 1.5),
                imageUrl: injector.get<UserBloc>().appUser?.profilePhoto ??
                    Assets.images.pngs.profileUser.path,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
