import '../presentation/ui/templates/debug_helper.dart';

class User {
  late int userId;
  late String firstName;
  late String lastName;
  late DateTime dateOfBirth;
  late String mobile;
  late String address1;
  late String address2;
  late String city;
  late String country;
  late String countryIso;
  late String email;
  late String cnic;
  late String passport;
  late String profilePicture;
  late String profileStatus;
  late String isActive;
  late int crmClientId;
  late int proTerminalClientId;
  late int onboardingId;
  late int onboardingUserId;
  late double annualIncome;
  late double totalSavings;
  late double monthlyExpenses;
  late String portfId;
  late String shariah;
  late String questionResponses;
  late String goalSelection;

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.mobile,
    required this.address1,
    required this.address2,
    required this.city,
    required this.country,
    required this.countryIso,
    required this.email,
    required this.cnic,
    required this.passport,
    required this.profilePicture,
    required this.profileStatus,
    required this.isActive,
    required this.crmClientId,
    required this.proTerminalClientId,
    required this.onboardingId,
    required this.onboardingUserId,
    required this.annualIncome,
    required this.totalSavings,
    required this.monthlyExpenses,
    required this.portfId,
    required this.shariah,
    required this.questionResponses,
    required this.goalSelection,
  });

  User.fromJson(Map<String, dynamic> json, Map<String, dynamic> profileJson) {
    userId = json['user_id'];

    firstName = json['first_name'] ?? " ";
    lastName = json['last_name'] ?? " ";
    dateOfBirth =
        json['dob'] != null ? DateTime.parse(json['dob']) : DateTime.now();
    mobile = json['mobile'] ?? " ";
    address1 = json['address1'] ?? " ";
    address2 = json['address2'] ?? " ";
    city = json['city'] ?? " ";
    country = json['country'] ?? " ";
    countryIso = json['countryISO'] ?? " ";

    email = json['email'];

    cnic = json['cnic'] ?? " ";
    passport = json['passport'] ?? " ";
    profilePicture = json['profile_picture'] ?? " ";

    DebugHelper.printAll("From User Model: Email: $email");
    profileStatus = json['profile_status'] ?? " ";
    isActive = json['is_active'] ?? " ";

    crmClientId = json['crm_client_id'] ?? 0;
    proTerminalClientId = json['pro_terminal_client_id'] ?? 0;

    onboardingId = profileJson['onboarding_id'] ?? 0;
    onboardingUserId = profileJson['onboarding_user_id'] ?? 0;

    annualIncome =
        json['annual_income'] != null && profileJson['annual_income'] != "null"
            ? profileJson['annual_income'].toDouble()
            : 0;

    totalSavings =
        json['total_savings'] != null && profileJson['total_savings'] != "null"
            ? profileJson['total_savings'].toDouble()
            : 0;

    monthlyExpenses = json['monthly_expenses'] != null &&
            profileJson['monthly_expenses'] != "null"
        ? profileJson['monthly_expenses'].toDouble()
        : 0;

    portfId = profileJson['portf_id'] ?? " ";
    shariah = profileJson['shariah'] ?? " ";
    questionResponses = profileJson['question_responses'] ?? " ";
    goalSelection = profileJson['goal_selection'] ?? " ";
  }

  Map<String, dynamic> toJson(User user) {
    Map<String, dynamic> userMap = {
      "user_id": user.userId,
      "first_name": user.firstName,
      "last_name": user.lastName,
      "mobile": user.mobile,
      "email": user.email,
    };
    return userMap;
  }
}
