import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/app.dart';
import 'package:wedfluencer/src/infrastructure/localization/global_translation.dart';

import 'src/presentation/bloc/translation/translation_bloc.dart';
import 'src/presentation/ui/config/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  List<String> supportedLanguages = ["en", "ar"];
  await translations.init(supportedLanguages, fallbackLanguage: 'en');
  initVideoPlayer();
  // globals.cameras = await availableCameras();
  return runApp(
    BlocProvider(
      create: (context) => TranslationBloc(
        TranslationState(locale: translations.locale),
        // TranslationState(locale: Locale.fromSubtags(languageCode: "en")),
      ),
      child: const App(),
    ),
  );
}
