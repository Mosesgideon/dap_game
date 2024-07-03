import 'package:dap_game/core/services/network/flutterwave_network_service.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/services/network/url_config.dart';
import 'package:dap_game/features/wallets/data/models/fetch_bank_response.dart';
import 'package:dap_game/features/wallets/data/models/verify_bank_response.dart';
import 'package:dap_game/features/wallets/dormain/fetch_bank_repository.dart';

class BankRepositoryImpl extends BankRepository {
  final FlutterWaveNetworkService _networkService = FlutterWaveNetworkService(
      authToken: UrlConfig.flutterWaveSecretKey, baseUrl: '');

  @override
  Future<FetchBankResponse> selectBank(String countryCode) async {
    try {
      var response = await _networkService.call(
          UrlConfig.fetchBank(countryCode: countryCode), RequestMethod.get);
      var bankResponse = FetchBankResponse.fromJson(response.data);

      return bankResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerifyBankAccountResponse> verifyBankAccount(
      String accountNumber, String bankCode) async {
    try {
      var response = await _networkService.call(
          UrlConfig.verifyBankEndpoint, RequestMethod.post,
          data: {"account_number": accountNumber, "account_bank": bankCode});
      var bankResponse = VerifyBankAccountResponse.fromJson(response.data);

      return bankResponse;
    } catch (e) {
      rethrow;
    }
  }
}
