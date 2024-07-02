part of 'user_proposals_bloc.dart';

abstract class UserProposalsEvent {}

class GetUserProposals extends UserProposalsEvent {
  final String accessToken;
  final String skip;
  final bool isMe;
  final List<ProposalVideo> proposalVideos;
  String? range;

  GetUserProposals(
      {required this.accessToken,
      required this.isMe,
      required this.skip,
      required this.proposalVideos,
      this.range});
}
