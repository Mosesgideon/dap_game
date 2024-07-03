import 'package:dap_game/features/authentiction/data/models/auth_success_rsponse.dart';
import 'package:dap_game/features/authentiction/data/models/register_payload.dart';

abstract class AuthRepository{
  Future<AuthSuccessResponse> register(RegisterPayload payload);
  Future<AuthSuccessResponse> login(String user_id, String password);
  Future<AuthSuccessResponse> authenticateWithGoogle({DateTime? dob});
  Future<dynamic> authenticateWithApple();
  Future<dynamic> sendOtp(String email);
  Future<dynamic> verifyOtp(String otp, String email);
  Future<dynamic> createNewPassword({required String email, required String newPassword,required String password_confirmation});
}