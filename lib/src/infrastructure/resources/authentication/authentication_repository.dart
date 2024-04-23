import '../../../models/user.dart';
import 'authentication_provider.dart';

class AuthenticationRepository {
  final authenticationProvider = AuthenticationProvider();
  Future<WedfluencerUser> loginUser({
    required String email,
    required String password,
  }) =>
      authenticationProvider.loginUser(email: email, password: password);
  Future registerEmailAndGetOtp({
    required String email,
    required String password,
    required String confirmPassword,
  }) =>
      authenticationProvider.registerEmailAndGetOtp(
          email: email, password: password, confirmPassword: confirmPassword);

  Future verifyOtp({
    required String otp,
    required User user,
  }) =>
      authenticationProvider.verifyOtp(user: user, otp: otp);

  Future sendPhoneOtp({
    required String weddingDate,
    required String city,
    required String countyCode,
    required String phone,
    required String weddingType,
    required String phoneNumber,
    required int guests,
    required User user,
  }) =>
      authenticationProvider.sendPhoneOtp(
          weddingDate: weddingDate,
          city: city,
          guests: guests,
          countyCode: countyCode,
          phone: phone,
          weddingType: weddingType,
          phoneNumber: phoneNumber,
          user: user);

  Future<WedfluencerUser> verifyPhoneOtpAndRegister({
    required String weddingDate,
    required String city,
    required String countyCode,
    required String phone,
    required String weddingType,
    required String phoneNumber,
    required String otp,
    required User user,
    required int guests,
  }) =>
      authenticationProvider.verifyPhoneOtpAndRegister(
          weddingDate: weddingDate,
          city: city,
          countyCode: countyCode,
          phone: phone,
          weddingType: weddingType,
          phoneNumber: phoneNumber,
          otp: otp,
          user: user,
          guests: guests);
}
