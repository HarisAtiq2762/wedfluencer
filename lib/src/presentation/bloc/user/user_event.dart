part of 'user_bloc.dart';

abstract class UserEvent {}

class GetEmailPassword extends UserEvent {
  final String email;
  final String password;
  GetEmailPassword({required this.email, required this.password});
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
