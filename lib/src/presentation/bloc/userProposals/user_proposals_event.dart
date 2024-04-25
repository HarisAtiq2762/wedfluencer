part of 'user_proposals_bloc.dart';

abstract class UserProposalsEvent {}

class GetUserProposals extends UserProposalsEvent {
  final String accessToken;
  GetUserProposals({required this.accessToken});
}
