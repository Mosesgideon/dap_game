import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/services/network/url_config.dart';
import 'package:dap_game/features/wallets/data/models/beneficiary_payload.dart';
import 'package:dap_game/features/wallets/data/models/beneficiary_response.dart';
import 'package:dap_game/features/wallets/dormain/beneficiaryrepository.dart';

class BeneficiaryRepositoryImpl extends BeneficiaryRepository {
  NetworkService _networkService;

  BeneficiaryRepositoryImpl(this._networkService);

  @override
  Future<BeneficiaryResponse> addBeneficiary(
      AddBeneficiaryPaylod payload) async {
    var response = await _networkService.call(
        UrlConfig.AddwalletBeneficiary, RequestMethod.post,
        data: payload.toJson());
    logger.e(response.data.toString());
    return BeneficiaryResponse.fromJson(response.data);
  }

  @override
  Future<BeneficiaryResponse> fetchBeneficiary() async {
    try {
      var response = await _networkService.call(
          UrlConfig.fetchwalletBeneficiary, RequestMethod.post);
      return BeneficiaryResponse.fromJson(response.data);
    } catch (e, stack) {

      logger.e(e.toString(), stackTrace: stack);
      rethrow;

    }
  }
}
