import 'package:wedfluencer/src/infrastructure/resources/user/user_provider.dart';
import 'package:wedfluencer/src/models/proposal_video_api_response.dart';

import '../../../models/video.dart';

class UserRepository {
  final userProvider = UserProvider();
  Future<List<VideoData>> getExploreVideos() => userProvider.getExploreVideos();
  Future<ProposalVideoApiResponse> getProposalVideos(
          {required String accessToke}) =>
      userProvider.getProposalVideos(accessToken: accessToke);
}
