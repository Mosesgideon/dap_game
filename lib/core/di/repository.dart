import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/authentiction/data/repository/authrepository_impl.dart';
import 'package:dap_game/features/authentiction/domain/repository/authrepository.dart';
import 'package:dap_game/features/games/lottery/data/repository/lottery_repository_impl.dart';
import 'package:dap_game/features/games/lottery/dormain/repository/lottery_game_repository.dart';
import 'package:dap_game/features/games/shared/dormain/repository/games_repository.dart';
import 'package:dap_game/features/games/spinwin/data/repository/spin_win_repository.dart';
import 'package:dap_game/features/games/spinwin/dormain/repository/spin_win_repository.dart';
import 'package:dap_game/features/notifications/data/repository/notifications_repository_impl.dart';
import 'package:dap_game/features/notifications/dormain/repository/notifications_repository.dart';
import 'package:dap_game/features/profile/data/repository/account_repository_impl.dart';
import 'package:dap_game/features/profile/domain/repository/account_repository.dart';
import 'package:dap_game/features/settings/data/repository/faq_repo_impl.dart';
import 'package:dap_game/features/settings/domain/repository/faq_repo.dart';
import 'package:dap_game/features/wallets/data/repository/beneficiary_repository_impl.dart';
import 'package:dap_game/features/wallets/data/repository/fetch_bank_repository_impl.dart';
import 'package:dap_game/features/wallets/data/repository/wallet_repository_impl.dart';
import 'package:dap_game/features/wallets/dormain/beneficiaryrepository.dart';
import 'package:dap_game/features/wallets/dormain/fetch_bank_repository.dart';
import 'package:dap_game/features/wallets/dormain/wallet_repository.dart';
import 'package:get_it/get_it.dart';

import '../../features/games/shared/data/repository/games_repository_impl.dart';

void setup(GetIt getIt) {
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(injector.get()));
  getIt.registerLazySingleton<GamesRepository>(
      () => GameRepositoryImpl(injector.get()));
  getIt.registerLazySingleton<LotteryGameRepository>(
      () => LotteryGameRepositoryImpl(injector.get()));
  getIt.registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(injector.get()));
  // getIt.registerLazySingleton<AccountRepository>(
  //     () => AccountRepositoryImpl(injector.get()));
  getIt.registerLazySingleton<FaqRepository>(
      () => FaqRepositoryImpl(injector.get()));
  getIt.registerLazySingleton<WalletRepository>(
      () => WalletRepositoryImpl(injector.get()));
  getIt.registerLazySingleton<BankRepository>(
      () => BankRepositoryImpl());
  getIt.registerLazySingleton<BeneficiaryRepository>(
      () => BeneficiaryRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<SpinWinRepository>(
      () => SpinWinRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<NotificationsRepository>(
      () => NotificationsRepositoryImpl(getIt.get()));
}
