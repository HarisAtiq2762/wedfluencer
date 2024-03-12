import 'package:wedfluencer/src/presentation/ui/screens/authentication/login_screen.dart';
import 'package:wedfluencer/src/presentation/ui/screens/legal/data_privacy_screen.dart';
import 'package:wedfluencer/src/presentation/ui/screens/legal/imprint.dart';
import 'package:wedfluencer/src/presentation/ui/screens/legal/terms_screen.dart';
import 'package:wedfluencer/src/presentation/ui/screens/onboarding/birthday_screen.dart';
import 'package:wedfluencer/src/presentation/ui/screens/onboarding/onboarding_screen.dart';
import 'package:wedfluencer/src/presentation/ui/screens/onboarding/upload_profile_screen.dart';
import '../screens/authentication/register_screen.dart';
import '../screens/onboarding/welcome_screen.dart';
import '../screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.routeName: (ctx) => const SplashScreen(),
  WelcomeScreen.routeName: (ctx) => const WelcomeScreen(),
  OnboardingScreen.routeName: (ctx) => const OnboardingScreen(),
  LoginScreen.routeName: (ctx) => const LoginScreen(),
  RegistrationScreen.routeName: (ctx) => const RegistrationScreen(),
  BirthdayScreen.routeName: (ctx) => const BirthdayScreen(),
  UploadProfileScreen.routeName: (ctx) => const UploadProfileScreen(),
  TermsScreen.routeName: (ctx) => const TermsScreen(),
  DataPrivacyScreen.routeName: (ctx) => const DataPrivacyScreen(),
  ImprintScreen.routeName: (ctx) => const ImprintScreen(),
};
