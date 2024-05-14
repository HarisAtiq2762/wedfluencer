part of 'user_proposals_bloc.dart';

abstract class UserProposalsEvent {}

class GetUserProposals extends UserProposalsEvent {
  final String accessToken;
  final bool isMe;
  GetUserProposals({required this.accessToken, required this.isMe});
}
