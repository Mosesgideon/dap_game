import 'package:dap_game/features/wallets/data/models/wallet_details_response.dart';

abstract class WalletRepository {
  Future<WalletDetailsResponse> getWalletDetails();

  Future<dynamic> requestWithdrawal(
      {required double amount, required int beneficiaryId});

  Future<dynamic> swap({required double amount, required String swapType});
}
