import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:dap_game/core/services/data/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  late Animation<double> animation;
  AnimationController? animationCtrl;

  @override
  void initState() {
    super.initState();
    animationCtrl = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(
        parent: animationCtrl!,
        curve: Curves.easeIn,
      ),
    );

    // Future.delayed(Duration.zero, () {
    //
    //   ref.read(setupProfileProvider.notifier).getDataConfigs();
    //   // ref.read(locationProvider.notifier).caller();
    // });

    animationCtrl?.forward();
    animation.addListener(() async {
      if (animation.isCompleted ?? false) {
        _goToNextScreen();
      }
    });
  }

  @override
  void dispose() {

    super.dispose();
    dialogKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: const BoxDecoration(color: Pallets.orange),
        child: Stack(
          children: [
            SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: Center(
                child: ImageWidget(
                  imageUrl: Assets.images.pngs.logo.path,
                  imageType: ImageWidgetType.asset,
                  color: Pallets.white,
                  size: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  SpinKitFadingCircle(
                    size: 50,
                    color: Pallets.white,
                  ),
                  50.verticalSpace
                ],
              ),
            )
          ],
        ),
        // child: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       ImageWidget(
        //         imageUrl: Assets.images.pngs.logo.path,
        //         imageType: ImageWidgetType.asset,
        //         color: Pallets.white,
        //         size: 100,
        //         fit: BoxFit.cover,
        //       ),
        //       8.verticalSpace,
        //       const TextView(
        //         text: "DAP GAME",
        //         fontSize: 25,
        //         fontWeight: FontWeight.w700,
        //         color: Pallets.midblue,
        //       ),
        //       const TextView(
        //         text: "A Journey Through Memory",
        //         fontSize: 18,
        //         fontWeight: FontWeight.w500,
        //         color: Pallets.midblue,
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }

  void _goToNextScreen() {

    if (SessionManager().hasOnboarded) {
      context.goNamed(PageUrl.home);
    }else{
      context.goNamed(PageUrl.onBoardingPage);

    }
    // context.goNamed(PageUrl.home);
  }
}
