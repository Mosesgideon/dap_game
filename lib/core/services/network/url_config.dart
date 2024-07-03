enum Environment { development, staging, qa, production }

class UrlConfig {
  static Environment environment = Environment.production;

  static const String STAGING_URL = String.fromEnvironment('DEV_BASE_URL');
  static const String PRODUCTION_URL = String.fromEnvironment('PROD_BASE_URL');

  static const String imageBaseUrl = String.fromEnvironment('IMAGE_BASE_URL');
  static const String FLAGS_BASE_URL = String.fromEnvironment('FLAGS_URL');
  static const String dojahTestAppId = String.fromEnvironment('DOJAH_APP_ID');
  static const String dojahTestPublicKey =
      String.fromEnvironment('DOJAH_PUBLIC_KEY');
  static const String facePlusTestApiKey =
      String.fromEnvironment('FACE_PLUS_TEST_API_KEY');
  static const String facePlusTestApiSecret =
      String.fromEnvironment('FACE_PLUS_TEST_API_SECRET');
  static const String messageUserEmail =
      String.fromEnvironment('MESSAGE_USER_EMAIL');
  static const String messageUserPassKey =
      String.fromEnvironment('MESSAGE_USER_PASSKEY');
  static const String supportNumber = String.fromEnvironment('SUPPORT_NUMBER');
  static const String supportEmail = String.fromEnvironment('SUPPORT_EMAIL');
  static const String flutterWavePublicTestKey =
      String.fromEnvironment('FLUTTER_WAVE_TEST_KEY');
  static const String flutterWaveSecretTestKey =
      String.fromEnvironment('FLUTTER_WAVE_SECRET_TEST_KEY');

  static const String flutterWavePublicLiveKey =
      String.fromEnvironment('FLUTTER_WAVE_LIVE_KEY');
  static const String flutterWaveSecretLiveKey =
      String.fromEnvironment('FLUTTER_WAVE_SECRET_LIVE_KEY');

  // static const String facePlusProdApiKey =
  //     String.fromEnvironment('FACE_PLUS_PROD_API_KEY');
  // static const String facePlusProdApiSecret =
  //     String.fromEnvironment('FACE_PLUS_PROD_API_SECRET');
  static final coreBaseUrl =
      environment == Environment.production ? PRODUCTION_URL : STAGING_URL;

  static final flutterWavePublicKey = environment == Environment.production
      ? flutterWavePublicLiveKey
      : flutterWavePublicTestKey;
  static final flutterWaveSecretKey = environment == Environment.production
      ? flutterWaveSecretLiveKey
      : flutterWaveSecretTestKey;

  static const String signIn = '/signin';

  static String getFlag(String path) =>
      '$FLAGS_BASE_URL${path.toUpperCase()}/shiny/64.png';
  static const String signUp = '/signup';
  static const String sendOtp = '/forgot-password';
  static const String verifyOtp = '/verify-otp';
  static const String createnew_password = '/reset-password';
  static const String signout = '/signout';
  static const String googleAuth = '/google_auth';
  static const String deleteAccount = '/user/delete';
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/update-profile';
  static const String faq = '/fetch-faqs';
  static const String contactSupport = '/contact-support';
  static const String fetch_countries = '/user/fetch_countries';

  static String getGamesCategoryEndpoint = '/games/categories';
  static String fetchWalletDetails = '/wallet/fetch-details';
  static String requestWithdrawal = '/payments/request-withdrawal';
  static String swap = '/wallet/coin/swap';

  static String getGamesEndpoint = '';
  static String leaderboard = '/games/leaders';

  static String verifyBankEndpoint =
      'https://api.flutterwave.com/v3/accounts/resolve';
  static String gameDrawEndpoint = '/games/lottery/fetch-draw';
  static String playNumberGame = '/games/lottery/play';
  static String gamesPlayed = '/games/lottery/fetch-games-played';
  static String gameDetails = '/games/lottery/fetch-played-game-details';
  static String gameDraws = '/games/results/draw-list';
  static String drawResults = '/games/results/draw-result';
  static String AddwalletBeneficiary = '/payments/add-beneficiary';
  static String fetchwalletBeneficiary = '/payments/fetch-beneficiaries';

  static String fetchBank({String? countryCode}) =>
      'https://api.flutterwave.com/v3/banks/${countryCode ?? "NG"}';

  static String playSpinGame = '/games/spinning_wheel/play';

  static String updateSpinGame = '/games/spinning_wheel/update_current_play';

  static String getNotifications = "/notifications/fetch";
}
