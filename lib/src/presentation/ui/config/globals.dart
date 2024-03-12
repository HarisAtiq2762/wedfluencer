const String error500 =
    "There is some problem in the connection. Please check back later";
const String socketExceptionError = 'Please check your internet connection';
const String accessTokenInvalidError =
    "An unknown error occured. Please try again";

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

bool isDoctor = false;

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
