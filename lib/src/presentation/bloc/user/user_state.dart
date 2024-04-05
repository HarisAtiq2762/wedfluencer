part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class Loading extends UserState {}

class GotEmailPassword extends UserState {
  final User user;
  GotEmailPassword({required this.user});
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
