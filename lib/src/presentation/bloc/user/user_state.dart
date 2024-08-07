part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class Loading extends UserState {}

class GotEmailPassword extends UserState {
  final User user;

  GotEmailPassword({required this.user});
}

class OtpVerified extends UserState {
  final String otp;
  final User user;

  OtpVerified({required this.user, required this.otp});
}

class GotError extends UserState {
  final String error;

  GotError({required this.error});
}

class GotUserChoiceForWeddingBusiness extends UserState {
  final User user;

  GotUserChoiceForWeddingBusiness({required this.user});
}

class GotUserChoiceForGettingMarried extends UserState {
  final User user;

  GotUserChoiceForGettingMarried({required this.user});
}

class GotUserProfileDetails extends UserState {
  final User user;

  GotUserProfileDetails({required this.user});
}

class GotUserWeddingDetails extends UserState {
  final String weddingType;
  final String weddingDate;
  final int guestCount;
  final String weddingLocation;
  final User user;

  GotUserWeddingDetails({
    required this.weddingDate,
    required this.weddingType,
    required this.guestCount,
    required this.weddingLocation,
    required this.user,
  });
}

class PhoneOtpSent extends UserState {
  final String weddingDate;
  final String city;
  final String countryCode;
  final String phone;
  final String weddingType;
  final String phoneNumber;
  final User user;
  final int guests;

  PhoneOtpSent({
    required this.weddingDate,
    required this.weddingType,
    required this.guests,
    required this.phoneNumber,
    required this.user,
    required this.city,
    required this.countryCode,
    required this.phone,
  });
}

class UserLoggedIn extends UserState {
  final WedfluencerUser user;

  UserLoggedIn({required this.user});
}
