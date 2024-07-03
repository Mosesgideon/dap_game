import 'dart:io';

import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/services/firebase/notifiactions.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/services/network/url_config.dart';
import 'package:dap_game/features/authentiction/data/models/auth_success_rsponse.dart';
import 'package:dap_game/features/authentiction/data/models/google_auth_payload.dart';
import 'package:dap_game/features/authentiction/data/models/register_payload.dart';
import 'package:dap_game/features/authentiction/domain/repository/authrepository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl extends AuthRepository {
  NetworkService _networkService;

  AuthRepositoryImpl(this._networkService);

  @override
  Future<AuthSuccessResponse> login(String user_id, String password) async {
    final response = await _networkService.call(
        UrlConfig.signIn, RequestMethod.post,
        data: {"user_id": user_id, "password": password});
    return AuthSuccessResponse.fromJson(response.data);
  }

  @override
  Future<AuthSuccessResponse> register(RegisterPayload payload) async {
    try {
      final response = await _networkService
          .call(UrlConfig.signUp, RequestMethod.post, data: payload.toJson());
      return AuthSuccessResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      rethrow;
    }
  }

  @override
  Future authenticateWithApple() async {}

  @override
  Future<AuthSuccessResponse> authenticateWithGoogle({DateTime? dob}) async {
    try {
      await GoogleSignIn().signOut();

      final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: [
        'email',
        'profile',
      ]).signIn();

      if (googleUser != null) {
        return await registerWithGoogle(
          googleUser,
          deviceId: notiToken, dob: dob,
        );
      } else {
        throw 'Google auth failed.';
      }
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      throw e.toString();
    }
  }

  @override
  Future createNewPassword(
      {required String email,
      required String newPassword,
      required String password_confirmation}) async {
    try {
      var response = await _networkService
          .call(UrlConfig.createnew_password, RequestMethod.post, data: {
        "email": email,
        "password": newPassword,
        "password_confirmation": password_confirmation
      });
      return response.data;
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      rethrow;
    }
  }

  @override
  Future sendOtp(String email) async {
    try {
      var response = await _networkService
          .call(UrlConfig.sendOtp, RequestMethod.post, data: {"email": email});
      return response.data;
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      rethrow;
    }
  }

  @override
  Future verifyOtp(String otp, String email) async {
    try {
      var response = await _networkService.call(
          UrlConfig.verifyOtp, RequestMethod.post,
          data: {"token": otp, "email": email});
      return response.data;
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      rethrow;
    }
  }

  Future<AuthSuccessResponse> registerWithGoogle(GoogleSignInAccount googleUser,
      {required deviceId,  DateTime? dob}) async {
    GoogleSignInPayload payload = GoogleSignInPayload(
        googleId: googleUser.id,
        username: googleUser.displayName ?? '',
        email: googleUser.email,
        firstname: googleUser.displayName?.split(' ').firstOrNull ?? '',
        lastname: googleUser.displayName?.split(' ').lastOrNull ?? '',
        referral: '',
        deviceToken: notiToken,
        dob: dob,
        devicePlatform: Platform.operatingSystem);
    try {
      final response = await _networkService.call(
          UrlConfig.googleAuth, RequestMethod.post,
          data: payload.toJson());
      return AuthSuccessResponse.fromJson(response.data);
    } on Exception catch (e) {
      rethrow;
    }
  }
}
