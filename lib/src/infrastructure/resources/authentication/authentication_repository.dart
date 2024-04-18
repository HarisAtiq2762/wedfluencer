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
}
