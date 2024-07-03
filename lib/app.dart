import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:dap_game/app_config.dart';
import 'package:dap_game/core/services/network/url_config.dart';
import 'package:dap_game/core/services/theme_service/app_theme.dart';
import 'core/constants/package_exports.dart';
import 'core/navigation/routes.dart';

void main() {
  AppConfig.initializeAndRunInstance(
      appName: "Dap Games", enviroment: Environment.staging);
}

class DapGameApp extends StatelessWidget {
  const DapGameApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 930),
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      builder: (contextAlt, child) {
        return OverlaySupport.global(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: MaterialApp.router(
              title: "Dap Game",
              //TODO: SET LOCALE HERE
              // locale: ref.watch(localeProvider).locale,
              localizationsDelegates: const [
                // S.delegate,
                // GlobalMaterialLocalizations.delegate,
                // GlobalWidgetsLocalizations.delegate,
                // GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'), // English
                Locale('es'), // Spanish
              ],

              //
              theme: AppTheme.lightTheme,
              // darkTheme: AppTheme.darkTheme,

              routerConfig: CustomRoutes.goRouter,
            ),
          ),
        );
      },
    );
  }
}
