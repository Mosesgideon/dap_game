import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/services/network/url_config.dart';
import 'package:dap_game/features/wallets/data/models/make_withdrawal_response.dart';
import 'package:dap_game/features/wallets/data/models/wallet_details_response.dart';
import 'package:dap_game/features/wallets/dormain/wallet_repository.dart';

class WalletRepositoryImpl extends WalletRepository {
  final NetworkService _networkService;

  WalletRepositoryImpl(this._networkService);

  @override
  Future<WalletDetailsResponse> getWalletDetails() async {
    try {
      final response = await _networkService.call(
          UrlConfig.fetchWalletDetails, RequestMethod.post);
      return WalletDetailsResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future requestWithdrawal(
      {required double amount, required int beneficiaryId}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.requestWithdrawal, RequestMethod.post,
          data: {"amount": amount, "beneficiary_id": beneficiaryId});
      return MakeWithdrawalResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future swap({required double amount, required String swapType}) async {
    // TODO: implement swap
    try {
      final response = await _networkService.call(
          UrlConfig.swap, RequestMethod.post,
          data: {"amount": amount, "swap_type": swapType});
      return response.data;
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      rethrow;
    }
  }
}
