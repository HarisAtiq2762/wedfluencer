import 'package:video_player/video_player.dart';
import 'package:wedfluencer/src/models/user.dart';

String error500 =
    "There is some problem in the connection. Please check back later";
const String socketExceptionError = 'Please check your internet connection';
const String accessTokenInvalidError =
    "An unknown error occurred. Please try again";
String serverUrlGlobal =
    // 'https://main-api-dev.ashymushroom-d0330ebd.eastus2.azurecontainerapps.io/api/';
    'http://10.0.2.2:4000/api/';
String userTokenGlobal = '';

const googleApiKey = 'AIzaSyBjh9vXOPFVn_RkYyBPvDF8VYmOrD76q0s';

Map<double, String> modelReturnDictionary = {
  0.01: "modelReturnVeryConservative",
  0.02: "modelReturnConservative",
  0.04: "modelReturnModerate",
  0.06: "modelReturnAggressive",
  0.08: "modelReturnVeryAggressive",
};

Map<String, double> modelReturnRisk = {
  "veryconservative": 0.01,
  "conservative": 0.02,
  "moderate": 0.04,
  "aggressive": 0.06,
  "veryaggressive": 0.08,
};

User user = User(
    email: 'email',
    password: 'password',
    isInWeddingBusiness: false,
    isGettingMarried: false,
    firstName: 'firstName',
    lastName: 'lastName',
    userName: 'userName',
    phoneNumber: 'phoneNumber');

VideoPlayerController controller =
    VideoPlayerController.asset('assets/videos/video1.MP4');

Future<void> initVideoPlayer() async {
  await controller.initialize();
}

class Globals {
  static final Globals _singleton = Globals._internal();
  factory Globals() {
    return _singleton;
  }
  void updateIsDoctor(bool isDoctor) {
    isDoctor = isDoctor;
  }

  Globals._internal();
}
