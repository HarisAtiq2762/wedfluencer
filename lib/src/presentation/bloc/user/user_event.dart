part of 'user_bloc.dart';

abstract class UserEvent {}

class UserLoading extends UserEvent {}

class LoginUser extends UserEvent {
  final String email;
  final String password;

  LoginUser({required this.email, required this.password});
}

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
  final bool isPhone;

  VerifyOtp({required this.otp, required this.user, required this.isPhone});
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

class GetUserWeddingDetails extends UserEvent {
  final String weddingType;
  final String weddingDate;
  final int guestCount;
  final String weddingLocation;
  final User user;
  final Map<String, double> location;

  GetUserWeddingDetails({
    required this.weddingDate,
    required this.weddingType,
    required this.guestCount,
    required this.weddingLocation,
    required this.user,
    required this.location,
  });
}

class GetUserPhoneOtp extends UserEvent {
  final String weddingDate;
  final String city;
  final String countryCode;
  final String phone;
  final String weddingType;
  final String phoneNumber;
  final int guests;
  final Map<String, double> location;
  final User user;

  GetUserPhoneOtp({
    required this.user,
    required this.phoneNumber,
    required this.weddingType,
    required this.phone,
    required this.countryCode,
    required this.city,
    required this.weddingDate,
    required this.guests,
    required this.location,
  });
}

class VerifyPhoneOtpAndRegister extends UserEvent {
  final String weddingDate;
  final String city;
  final String countryCode;
  final String phone;
  final String weddingType;
  final String phoneNumber;
  final String otp;
  final User user;
  final int guests;
  final Map<String, double> location;

  VerifyPhoneOtpAndRegister(
      {required this.otp,
      required this.guests,
      required this.user,
      required this.phoneNumber,
      required this.weddingType,
      required this.phone,
      required this.countryCode,
      required this.city,
      required this.weddingDate,
      required this.location});
}
