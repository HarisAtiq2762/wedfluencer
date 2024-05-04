import 'dart:io';

import 'package:wedfluencer/src/infrastructure/resources/user/user_provider.dart';
import 'package:wedfluencer/src/models/proposal_video_api_response.dart';

import '../../../models/producer_event.dart';
import '../../../models/referral_code.dart';
import '../../../models/video.dart';

class UserRepository {
  final userProvider = UserProvider();

  Future<List<VideoData>> getExploreVideos() => userProvider.getExploreVideos();

  Future<ProposalVideoApiResponse> getProposalVideos(
          {required String accessToke}) =>
      userProvider.getProposalVideos(accessToken: accessToke);

  Future<String> uploadProposalVideo(
          {required File video,
          required String title,
          required String description}) =>
      userProvider.uploadProposalVideo(
          title: title, description: description, video: video);

  Future uploadProposalDetails({
    required String videoId,
    required List<String> categoryIds,
    required String title,
    required String eventId,
    required String accessToken,
  }) =>
      userProvider.uploadProposalDetails(
          accessToken: accessToken,
          videoId: videoId,
          categoryIds: categoryIds,
          title: title,
          eventId: eventId);

  Future<ReferralCode> verifyReferralCode({required String referralCode}) =>
      userProvider.verifyReferralCode(referralCode: referralCode);

  Future<List<ProducerEvent>> getProducerEvents() =>
      userProvider.getProducerEvents();
}
