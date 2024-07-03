import 'package:dap_game/common/database/local/userstorage.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/services/data/session_manager.dart';
import 'package:dap_game/features/authentiction/data/models/auth_success_rsponse.dart';
import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';

class AuthSuccessUseCase {
  final _userStorage = UserStorage();

  // final userWallet = UserWallet();

  void execute(AuthSuccessResponse response) {
    injector.get<UserBloc>().add(SaveUserEvent(response.data.user));
    _userStorage.saveUserToken(response.data.bearerToken);
    SessionManager().isLoggedIn = true;
    SessionManager().hasOnboarded = true;

    // // for wallet
    // injector.get<WalletBloc>().add(SaveWalletEvent());
    // userWallet.saveWallet(response.data.bearerToken);
    // SessionManager().isLoggedIn = true;
  }
}
