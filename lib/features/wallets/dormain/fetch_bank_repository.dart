import 'package:dap_game/features/wallets/data/models/fetch_bank_response.dart';
import 'package:dap_game/features/wallets/data/models/verify_bank_response.dart';

abstract class BankRepository {
  Future<FetchBankResponse> selectBank(String countryCode);

  Future<VerifyBankAccountResponse> verifyBankAccount(
      String accountNumber, String bankCode);
}
