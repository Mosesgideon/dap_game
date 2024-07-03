import 'package:dap_game/features/wallets/data/models/beneficiary_payload.dart';
import 'package:dap_game/features/wallets/data/models/beneficiary_response.dart';

abstract class BeneficiaryRepository{
  Future<BeneficiaryResponse> addBeneficiary(AddBeneficiaryPaylod payload);
  Future<BeneficiaryResponse> fetchBeneficiary();


}