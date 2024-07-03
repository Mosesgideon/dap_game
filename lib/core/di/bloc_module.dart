import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/authentiction/presentation/auth_bloc/auth_bloc.dart';
import 'package:dap_game/features/games/lottery/presentation/bloc/lottery_game_bloc.dart';
import 'package:dap_game/features/games/shared/presentation/bloc/games/games_bloc.dart';
import 'package:dap_game/features/notifications/presentation/bloc/notifications/notifications_bloc.dart';
import 'package:dap_game/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:dap_game/features/wallets/presentation/bloc/bank/bank_bloc.dart';
import 'package:dap_game/features/wallets/presentation/bloc/beneficiary/beneficiary_bloc.dart';
import 'package:dap_game/features/wallets/presentation/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:get_it/get_it.dart';

void setup(GetIt getIt) {

  getIt.registerLazySingleton(() => UserBloc());
  getIt.registerLazySingleton(() => AuthBloc(injector.get()));
  getIt.registerLazySingleton(() => GamesBloc(injector.get()));
  getIt.registerLazySingleton(() => LotteryGameBloc(injector.get()));
  getIt.registerLazySingleton(() => WalletBloc(injector.get()));
  getIt.registerLazySingleton(() => BankBloc(injector.get()));
  getIt.registerLazySingleton(() => ProfileBloc(injector.get()));
  getIt.registerLazySingleton(() => BeneficiaryBloc(injector.get()));
  getIt.registerLazySingleton(() => NotificationsBloc(injector.get()));

}
