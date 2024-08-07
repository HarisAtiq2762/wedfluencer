part of 'create_proposal_bloc.dart';

abstract class CreateProposalState {}

class CreateProposalInitial extends CreateProposalState {}

class CreateProposalError extends CreateProposalState {
  final String error;

  CreateProposalError({required this.error});
}

class CreateProposalLoading extends CreateProposalState {}

class CreateProposalDetailsProvided extends CreateProposalState {
  final bool isInWeddingShow;
  final String title;
  final String referralCode;
  final String weddingShowName;
  final String weddingLocation;
  final String weddingShowDate;
  final String eventId;
  final List<ValueItem<dynamic>> vendorCategories;

  CreateProposalDetailsProvided(
      {required this.title,
      required this.weddingLocation,
      required this.isInWeddingShow,
      required this.referralCode,
      required this.weddingShowDate,
      required this.weddingShowName,
      required this.vendorCategories,
      required this.eventId});
}

class CreateProposalVideoUploaded extends CreateProposalState {
  final String videoId;
  final String eventId;
  final bool isInWeddingShow;
  final String title;
  final String referralCode;
  final String weddingShowName;
  final String weddingLocation;
  final String weddingShowDate;
  final List<ValueItem<dynamic>> vendorCategories;
  final String azureAccountName;

  CreateProposalVideoUploaded({
    required this.videoId,
    required this.isInWeddingShow,
    required this.title,
    required this.weddingShowName,
    required this.weddingShowDate,
    required this.referralCode,
    required this.weddingLocation,
    required this.vendorCategories,
    required this.eventId,
    required this.azureAccountName,
  });
}

class CreateProposalDetailsUploaded extends CreateProposalState {}

class ReferralCodeVerified extends CreateProposalState {
  final ReferralCode referralCode;

  ReferralCodeVerified({required this.referralCode});
}
