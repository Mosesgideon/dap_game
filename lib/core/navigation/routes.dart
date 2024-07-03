import 'dart:convert';

import 'package:dap_game/core/navigation/path_params.dart';
import 'package:dap_game/features/authentiction/presentation/screens/forget_password_screen.dart';
import 'package:dap_game/features/authentiction/presentation/screens/onboarding_screen.dart';
import 'package:dap_game/features/authentiction/presentation/screens/otp_screen.dart';
import 'package:dap_game/features/authentiction/presentation/screens/reset_password.dart';
import 'package:dap_game/features/authentiction/presentation/screens/reset_success.dart';
import 'package:dap_game/features/authentiction/presentation/screens/sign_in_screen.dart';
import 'package:dap_game/features/authentiction/presentation/screens/sign_up_screen.dart';
import 'package:dap_game/features/authentiction/presentation/screens/splash_screen.dart';
import 'package:dap_game/features/dashboard/presentation/screens/base_page.dart';
import 'package:dap_game/features/dashboard/presentation/screens/home.dart';
import 'package:dap_game/features/games/lottery/data/models/get_games_categories_models.dart';
import 'package:dap_game/features/games/lottery/presentation/screen/games_details_screen.dart';
import 'package:dap_game/features/games/lottery/presentation/screen/lottery_game_screen.dart';
import 'package:dap_game/features/games/lottery/presentation/screen/lottery_results_screen.dart';
import 'package:dap_game/features/games/lottery/presentation/screen/select_draw_screen.dart';
import 'package:dap_game/features/games/shared/presentation/screens/category_games_screen.dart';
import 'package:dap_game/features/games/lottery/presentation/screen/country_game_screen.dart';
import 'package:dap_game/features/games/shared/presentation/screens/games_tab.dart';
import 'package:dap_game/features/games/lottery/presentation/screen/numbers_game_screen.dart';
import 'package:dap_game/features/games/lottery/presentation/screen/selection_screen.dart';
import 'package:dap_game/features/games/spinwin/presentation/screens/spinwin_screen.dart';
import 'package:dap_game/features/notifications/presentation/screens/notifications_screens.dart';
import 'package:dap_game/features/profile/presentation/screens/details_edit.dart';
import 'package:dap_game/features/profile/presentation/screens/personal_details.dart';

// import 'package:dap_game/features/profile/presentation/screens/edit_profile.dart';
import 'package:dap_game/features/profile/presentation/screens/profile_tab.dart';
import 'package:dap_game/features/settings/presentations/screens/delete_account.dart';
import 'package:dap_game/features/settings/presentations/screens/faq.dart';
import 'package:dap_game/features/settings/presentations/screens/live_chat_screen.dart';
import 'package:dap_game/features/settings/presentations/screens/notificationscreen.dart';
import 'package:dap_game/features/settings/presentations/screens/report_problem_screen.dart';
import 'package:dap_game/features/settings/presentations/screens/securityscreen.dart';
import 'package:dap_game/features/settings/presentations/screens/settings.dart';
import 'package:dap_game/features/settings/presentations/screens/support_center.dart';
import 'package:dap_game/features/settings/presentations/widgets/pushnotification.dart';
import 'package:dap_game/features/wallets/presentation/screens/accountdetails.dart';
import 'package:dap_game/features/wallets/presentation/screens/deposit_screen.dart';
import 'package:dap_game/features/wallets/presentation/screens/wallets_tab.dart';
import 'package:dap_game/features/wallets/presentation/screens/withdrawal_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dap_game/core/navigation/route_url.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');
final _shellNavigatorEKey = GlobalKey<NavigatorState>(debugLabel: 'shellE');

class CustomRoutes {
  static final goRouter = GoRouter(
    initialLocation: '/splash',
    // initialLocation: '/profile/setupProfileIntroPage/setupProfilePage',
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/splash',
        name: PageUrl.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/sign_in_screen',
        parentNavigatorKey: rootNavigatorKey,
        name: PageUrl.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/otp_screen',
        name: PageUrl.otpPage,
        builder: (context, state) => OTPScreen(
          email: state.uri.queryParameters[PathParam.email] ?? '',
        ),
      ),
      GoRoute(
        path: '/reset_password',
        name: PageUrl.passwordReset,
        builder: (context, state) => CreateNewPassword(
          email: state.uri.queryParameters[PathParam.email] ?? '',
        ),
      ),
      GoRoute(
        path: '/reset_success',
        name: PageUrl.passwordResetSuccess,
        builder: (context, state) => const ResetSuccess(),
      ),
      GoRoute(
        path: '/forget_password_screen',
        name: PageUrl.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/sign_up_screen',
        name: PageUrl.signUp,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: PageUrl.settings,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/notificationscreen',
        name: PageUrl.notificationsSettingScreen,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const NotificationsSettingScreen(),
      ),
      GoRoute(
        path: '/delete_account',
        name: PageUrl.delete_account,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const DeleteAccount(),
      ),
      GoRoute(
        path: '/securityscreen',
        name: PageUrl.securityscreen,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SecurityScreen(),
      ),
      GoRoute(
        path: '/pushnotification',
        name: PageUrl.pushnotification,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const PushNotification(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/edit_profile',
        name: PageUrl.edit_profile,
        builder: (context, state) => const PersonalDetails(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/faq',
        name: PageUrl.faq,
        builder: (context, state) => const FAQ_Screen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/support_center',
        name: PageUrl.support_center,
        builder: (context, state) => const SupportCenter(),
      ),
      GoRoute(
        path: '/details_edit',
        name: PageUrl.details_edit,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const EditPersonalDetails(),
      ),
      GoRoute(
        path: '/personal_details',
        name: PageUrl.personal_details,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const PersonalDetails(),
      ),
      GoRoute(
        path: '/accountdetails',
        name: PageUrl.accountdetails,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const AccountDetailsScreen(),
      ),
      GoRoute(
        path: '/withdrawal_screen',
        name: PageUrl.withdrawal_screen,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const WithdrawalScreen(),
      ),
      GoRoute(
        path: '/deposit_screen',
        name: PageUrl.deposit_screen,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const DepositScreen(),
      ),
      GoRoute(
        path: '/lottery',
        name: PageUrl.lottery,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => LotteryGameScreen(
          gameId: state.uri.queryParameters[PathParam.id] ?? '',
        ),
      ),
      GoRoute(
        path: '/categoryGames',
        name: PageUrl.categoryGames,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => CategoryGamesScreen(
          category: GameCategory.fromJson(
              jsonDecode(state.uri.queryParameters[PathParam.category] ?? '')),
        ),
      ),
      GoRoute(
        path: '/onBoardingPage',
        name: PageUrl.onBoardingPage,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/luckyNumbers',
        name: PageUrl.luckyNumbers,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => NoTransitionPage(
          child: LuckyNumberGameScreen(
            gameId: state.uri.queryParameters[PathParam.id] ?? '',
            game: DapGame.fromJson(
                jsonDecode(state.uri.queryParameters[PathParam.game] ?? '')),
          ),
        ),
      ),
      GoRoute(
        path: '/reportProblem',
        name: PageUrl.reportProblem,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: ReportProblemScreen(),
        ),
      ),
      GoRoute(
        path: '/liveChat',
        name: PageUrl.liveChat,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LiveChatScreen(),
        ),
      ),
      GoRoute(
        path: '/guessCountry',
        name: PageUrl.guessCountry,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => NoTransitionPage(
          child: GuessCountryGameScreen(
            gameId: state.uri.queryParameters[PathParam.id] ?? '',
            game: DapGame.fromJson(
                jsonDecode(state.uri.queryParameters[PathParam.game] ?? '')),
          ),
        ),
      ),
      GoRoute(
        path: '/lotteryGameDetails',
        name: PageUrl.lotteryGameDetails,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => NoTransitionPage(
          child: GamesDetailsScreen(
            gameId: state.uri.queryParameters[PathParam.id] ?? '',
            // game: DapGame.fromJson(
            //   jsonDecode(state.uri.queryParameters[PathParam.game] ?? '')),
          ),
        ),
      ),
      GoRoute(
        path: '/notificationsScreen',
        name: PageUrl.notificationsScreen,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: NotificationsScreen(

              // game: DapGame.fromJson(
              //   jsonDecode(state.uri.queryParameters[PathParam.game] ?? '')),

              ),
        ),
      ),
      GoRoute(
        path: '/myLotteryGames',
        name: PageUrl.myLotteryGames,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => NoTransitionPage(
          child: SelectionsScreen(
            gameName: state.uri.queryParameters[PathParam.gameName] ?? '',
            gameId: state.uri.queryParameters[PathParam.id] ?? '',
          ),
        ),
      ),
      GoRoute(
        path: '/lotteryGamesResult',
        name: PageUrl.lotteryGamesResult,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => NoTransitionPage(
          child: LotteryResultsScreen(
            drawId: state.uri.queryParameters[PathParam.id] ?? '',
          ),
        ),
      ),
      GoRoute(
        path: '/spinnin_wheel',
        name: PageUrl.spiningWheel,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => NoTransitionPage(
          child: SpinWinScreen(
            game: DapGame.fromJson(
                jsonDecode(state.uri.queryParameters[PathParam.game] ?? '')),
            // drawId: state.uri.queryParameters[PathParam.id] ?? '',
          ),
        ),
      ),
      GoRoute(
        path: '/selectDrawScreen',
        name: PageUrl.selectDrawScreen,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => NoTransitionPage(
          child: SelectDrawScreen(
            gameId: state.uri.queryParameters[PathParam.id] ?? '',
          ),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BasePage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAKey,
            routes: [
              GoRoute(
                path: '/home',
                name: PageUrl.home,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeScreen(),
                ),
                routes: [],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBKey,
            routes: [
              GoRoute(
                path: '/games',
                name: PageUrl.games,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: GamesTab(),
                ),
              ),
              // GoRoute(
              //   path: '/countryGame',
              //   name: PageUrl.countryGame,
              //   pageBuilder: (context, state) => const NoTransitionPage(
              //     child: GuessCountryScreen(),
              //   ),
              // ),
            ],
          ),
          // StatefulShellBranch(
          //   navigatorKey: _shellNavigatorCKey,
          //   routes: [
          //     GoRoute(
          //       path: '/results',
          //       name: PageUrl.results,
          //       pageBuilder: (context, state) => const NoTransitionPage(
          //         child: Results(),
          //       ),
          //       routes: [],
          //     ),
          //   ],
          // ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDKey,
            routes: [
              GoRoute(
                path: '/wallet',
                name: PageUrl.wallet,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: WalletsTab(),
                ),
                routes: const [],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorEKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: PageUrl.profile,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProfileTab(),
                ),
                routes: const [],
              ),
              // GoRoute(
              //   path: '/edit_profile',
              //   name: PageUrl.edit_profile,
              //   pageBuilder: (context, state) => const NoTransitionPage(
              //     child: PersonalDetails(),
              //   ),
              //   routes: const [],
              // ),
              // GoRoute(
              //   path: '/edit_profile',
              //   name: PageUrl.edit_profile,
              //   pageBuilder: (context, state) => const NoTransitionPage(
              //     child: EditProfileScreen(),
              //   ),
              //   routes: const [],
              // ),
            ],
          ),
        ],
      ),
    ],
  );
}
