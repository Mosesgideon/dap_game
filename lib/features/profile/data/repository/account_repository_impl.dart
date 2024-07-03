import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/services/network/url_config.dart';
import 'package:dap_game/features/profile/data/models/delete_account_payload.dart';
import 'package:dap_game/features/profile/data/models/delete_account_response.dart';
import 'package:dap_game/features/profile/data/models/fectcountryResponse.dart';
import 'package:dap_game/features/profile/data/models/profile_response.dart';
import 'package:dap_game/features/profile/data/models/update_profile_response.dart';
import 'package:dap_game/features/profile/domain/repository/account_repository.dart';
import 'package:dio/dio.dart';

class AccountRepositoryImpl extends AccountRepository {
  NetworkService _networkService;

  AccountRepositoryImpl(this._networkService);

  @override
  Future<ProfileResponse> profileAccount() async {
    var response =
        await _networkService.call(UrlConfig.profile, RequestMethod.post);
    return ProfileResponse.fromJson(response.data);
  }

  @override
  Future<DeleteAccountResponse> deleteAccount(
      DeletAccountPayload payload) async {
    var response = await _networkService.call(
        UrlConfig.deleteAccount, RequestMethod.post,
        data: payload.toJson());
    return DeleteAccountResponse.fromJson(response.data);
  }

  @override
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
  }) async {
    final FormData formData = FormData.fromMap({
      "username": username,
      "firstname": firstname,
      "lastname": lastname,
      "phone": phonNumber,
      "country": country,
      "dob": dob,
      "password": password,
      "old_password": oldPassword,
    });

    formData.files.addAll([
      if (coverImage != null)
        MapEntry("cover_photo", await MultipartFile.fromFile(coverImage)),
      if (profileImage != null)
        MapEntry("profile_photo", await MultipartFile.fromFile(coverImage!)),
    ]);

    var response = await _networkService
        .call(UrlConfig.updateProfile, RequestMethod.post, data: formData);
    return UpdateProfileResponse.fromJson(response.data);
  }

  @override
  Future<FetchCountriesResponse> fetchCountry() async {
    var response = await _networkService.call(
        UrlConfig.fetch_countries, RequestMethod.post);
    return FetchCountriesResponse.fromJson(response.data);
  }
}
