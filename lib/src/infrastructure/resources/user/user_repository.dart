import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:wedfluencer/src/infrastructure/resources/user/user_provider.dart';
import 'package:wedfluencer/src/models/proposal_video_api_response.dart';

import '../../../models/event_image.dart';
import '../../../models/producer_event.dart';
import '../../../models/producer_payment.dart';
import '../../../models/referral_code.dart';
import '../../../models/video.dart';

class UserRepository {
  final userProvider = UserProvider();

  Future<List<VideoData>> getExploreVideos() => userProvider.getExploreVideos();

  Future<ProposalVideoApiResponse> getProposalVideos(
          {required String accessToke,
          required bool isMe,
          String? range,
          required String skip}) =>
      userProvider.getProposalVideos(
          accessToken: accessToke, isMe: isMe, skip: skip, range: range);

  // Future<String> uploadProposalVideo(
  //         {required File video,
  //         required String title,
  //         required String description}) =>
  //     userProvider.uploadProposalVideo(
  //         title: title, description: description, video: video);
  Future<Map<String, String>> uploadProposalVideo({
    required File video,
    required String title,
    required String description,
    required String containerName,
  }) =>
      userProvider.uploadProposalVideoToBlob(
          video: video, containerName: containerName);

  Future<bool> uploadProposalDetails({
    required String videoId,
    required List<String> categoryIds,
    required String title,
    required String eventId,
    required String accessToken,
    required String fileName,
    required XFile file,
    required String accountName,
    required String referralCode,
  }) =>
      userProvider.uploadProposalDetails(
        accessToken: accessToken,
        videoId: videoId,
        categoryIds: categoryIds,
        title: title,
        eventId: eventId,
        fileName: fileName,
        file: file,
        accountName: accountName,
        referralCode: referralCode,
      );

  Future<ReferralCode> verifyReferralCode({required String referralCode}) =>
      userProvider.verifyReferralCode(referralCode: referralCode);

  Future<List<ProducerEvent>> getProducerEvents(
          {required String take, required String search}) =>
      userProvider.getProducerEvents(take: take, search: search);

  Future<EventImage> uploadEventImage({required File file}) =>
      userProvider.uploadEventImage(file: file);

  Future<ProducerEvent> createEvent({
    required List<ValueItem> categoryIds,
    required List<String> tags,
    required List<String> imageIds,
    required String title,
    required String description,
    required String location,
    required String locationDetails,
    required String referralCode,
    required String placeId,
    required DateTime startDate,
    required DateTime endDate,
    required String timezone,
  }) =>
      userProvider.createEvent(
        categoryIds: categoryIds,
        tags: tags,
        imageIds: imageIds,
        title: title,
        description: description,
        location: location,
        locationDetails: locationDetails,
        referralCode: referralCode,
        placeId: placeId,
        startDate: startDate,
        endDate: endDate,
        timezone: timezone,
      );

  Future<ProducerEvent> updateEventCoordinates({
    required ProducerEvent producerEvent,
    required double lat,
    required double lng,
  }) =>
      userProvider.updateEventCoordinates(
          producerEvent: producerEvent, lat: lat, lng: lng);

  Future updateWeddingDetails({
    required String city,
    required String date,
    required String type,
    required String guestsCount,
  }) =>
      userProvider.updateWeddingDetails(
          city: city, date: date, type: type, guestsCount: guestsCount);

  Future<List<ProducerPayment>> getPayments({
    required String search,
    required int page,
    required int take,
  }) =>
      userProvider.getPayments(search: search, page: page, take: take);
}
