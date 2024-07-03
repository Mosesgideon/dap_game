import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/services/network/url_config.dart';
import 'package:dap_game/features/settings/data/models/faq_response.dart';
import 'package:dap_game/features/settings/domain/repository/faq_repo.dart';

class FaqRepositoryImpl extends FaqRepository {
  NetworkService _networkService;

  FaqRepositoryImpl(this._networkService);

  @override
  Future<FaqResponse> faq() async {
    final response =
        await _networkService.call(UrlConfig.faq, RequestMethod.get);
    return FaqResponse.fromJson(response.data);
  }

}
