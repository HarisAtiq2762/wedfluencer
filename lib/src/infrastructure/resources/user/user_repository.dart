import 'package:wedfluencer/src/infrastructure/resources/user/user_provider.dart';

import '../../../models/video.dart';

class UserRepository {
  final userProvider = UserProvider();
  Future<List<VideoData>> getExploreVideos() => userProvider.getExploreVideos();
}
