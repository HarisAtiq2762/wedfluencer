import '../../../models/user.dart';
import 'authentication_provider.dart';

class AuthenticationRepository {
  final authenticationProvider = AuthenticationProvider();
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
    required User user,
  }) =>
      authenticationProvider.sendPhoneOtp(
          weddingDate: weddingDate,
          city: city,
          countyCode: countyCode,
          phone: phone,
          weddingType: weddingType,
          phoneNumber: phoneNumber,
          user: user);
}
