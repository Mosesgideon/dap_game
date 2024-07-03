import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/services/network/url_config.dart';
import 'package:dap_game/features/results/dormain/repository/results_repository.dart';

class ResultsRepositoryImpl extends ResultsRepository {
  final NetworkService _networkService;

  ResultsRepositoryImpl(this._networkService);

  @override
  Future getLotteryGameResults(DateTime? date) async {
    try {
      final response =
          await _networkService.call(UrlConfig.coreBaseUrl, RequestMethod.get);
    } catch (e) {
      rethrow;
    }
  }
}
