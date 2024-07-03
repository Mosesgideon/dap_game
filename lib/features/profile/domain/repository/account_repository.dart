import 'package:dap_game/features/profile/data/models/delete_account_payload.dart';
import 'package:dap_game/features/profile/data/models/delete_account_response.dart';
import 'package:dap_game/features/profile/data/models/fectcountryResponse.dart';
import 'package:dap_game/features/profile/data/models/profile_response.dart';
import 'package:dap_game/features/profile/data/models/update_profile_response.dart';

abstract class AccountRepository {
  Future<UpdateProfileResponse> updateProfile(
    String? username,
    String? coverImage,
    String? phonNumber,
    String? country,
    String? firstname,
    String? lastname,
    String? profileImage,
    String? dob, {
    String? password,
    String? oldPassword,
  });

  Future<DeleteAccountResponse> deleteAccount(DeletAccountPayload payload);

  Future<FetchCountriesResponse> fetchCountry();

  Future<ProfileResponse> profileAccount();
}
