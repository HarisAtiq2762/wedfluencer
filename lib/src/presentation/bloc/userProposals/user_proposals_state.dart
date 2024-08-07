part of 'user_proposals_bloc.dart';

abstract class UserProposalsState {}

class GotUserProposals extends UserProposalsState {
  final ProposalVideoApiResponse proposalVideoApiResponse;
  final String? timeline;
  GotUserProposals({required this.proposalVideoApiResponse, this.timeline});
}

class UserProposalsInitial extends UserProposalsState {}

class UserProposalsLoading extends UserProposalsState {}

class UserProposalsError extends UserProposalsState {
  final String error;
  UserProposalsError({required this.error});
}
