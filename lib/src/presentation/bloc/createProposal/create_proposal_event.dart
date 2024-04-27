part of 'create_proposal_bloc.dart';

abstract class CreateProposalEvent {}

class GetCreateProposalDetails extends CreateProposalEvent {
  final bool isInWeddingShow;
  final String title;
  final String referralCode;
  final String weddingShowName;
  final String weddingLocation;
  final String weddingShowDate;
  final String eventId;
  final List<ValueItem<dynamic>> vendorCategories;

  GetCreateProposalDetails({
    required this.isInWeddingShow,
    required this.title,
    required this.referralCode,
    required this.weddingShowName,
    required this.weddingShowDate,
    required this.weddingLocation,
    required this.vendorCategories,
    required this.eventId,
  });
}

class UploadCreateProposalVideo extends CreateProposalEvent {
  final File file;
  final String folder;
  final String description;
  final bool isInWeddingShow;
  final String title;
  final String referralCode;
  final String weddingShowName;
  final String weddingLocation;
  final String weddingShowDate;
  final String eventId;
  final List<ValueItem<dynamic>> vendorCategories;

  UploadCreateProposalVideo({
    required this.file,
    required this.folder,
    required this.description,
    required this.isInWeddingShow,
    required this.title,
    required this.referralCode,
    required this.weddingShowName,
    required this.weddingShowDate,
    required this.weddingLocation,
    required this.vendorCategories,
    required this.eventId,
  });
}

class UploadCreateProposalDetails extends CreateProposalEvent {
  final String videoId;
  final String title;
  final String accessToken;
  final String eventId;
  final List<String> categoryIds;

  UploadCreateProposalDetails({
    required this.title,
    required this.videoId,
    required this.eventId,
    required this.categoryIds,
    required this.accessToken,
  });
}

class VerifyReferralCode extends CreateProposalEvent {
  final String referralCode;
  VerifyReferralCode({required this.referralCode});
}
