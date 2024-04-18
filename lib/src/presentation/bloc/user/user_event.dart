part of 'user_bloc.dart';

abstract class UserEvent {}

class UserLoading extends UserEvent {}

class GetEmailPassword extends UserEvent {
  final String email;
  final String password;
  final String confirmPassword;
  GetEmailPassword(
      {required this.email,
      required this.password,
      required this.confirmPassword});
}

class VerifyOtp extends UserEvent {
  final String otp;
  final User user;
  VerifyOtp({required this.otp, required this.user});
}

class GetUserChoiceForWeddingBusiness extends UserEvent {
  final bool isInWeddingBusiness;
  final User user;
  GetUserChoiceForWeddingBusiness(
      {required this.isInWeddingBusiness, required this.user});
}

class GetUserChoiceForGettingMarried extends UserEvent {
  final bool isGettingMarried;
  final User user;
  GetUserChoiceForGettingMarried(
      {required this.isGettingMarried, required this.user});
}

class GetUserProfileDetails extends UserEvent {
  final String firstName;
  final String lastName;
  final String userName;
  final String phoneNumber;
  final User user;
  GetUserProfileDetails({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.phoneNumber,
    required this.user,
  });
}
