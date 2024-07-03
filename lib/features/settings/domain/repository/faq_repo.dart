import 'package:dap_game/features/settings/data/models/faq_response.dart';

abstract class FaqRepository {
  Future<FaqResponse> faq();
}
