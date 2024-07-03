import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/services/network/url_config.dart';
import 'package:dap_game/features/settings/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final NetworkService _service;

  SettingsRepositoryImpl(this._service);

  @override
  Future contactSupport(String subject, String message) async {
    try {
      final response = await _service
          .call(UrlConfig.contactSupport, RequestMethod.post, data: {
        "subject": subject,
        "message": message,
      });
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
