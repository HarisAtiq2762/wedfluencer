import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:wedfluencer/src/presentation/bloc/theme/theme_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/translation/translation_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/config/routes.dart';
import 'package:wedfluencer/src/presentation/ui/config/theme.dart';
import 'package:wedfluencer/src/presentation/ui/screens/splash/splash_screen.dart';
import 'infrastructure/localization/global_translation.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const themeColor = Color(0xFFFF9DAD);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationBloc, TranslationState>(
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ThemeBloc()
                ..add(SetInitialTheme(themeData: wedfluencerTheme)),
            ),
          ],
          child: OverlaySupport(
            child: MaterialApp(
              builder: (context, child) => ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                ],
              ),
              locale: state.locale,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: translations.supportedLocales(),
              debugShowCheckedModeBanner: false,
              theme: wedfluencerTheme,
              routes: routes,
              // home: const FirstTimeScreen(),
              home: const SplashScreen(),
            ),
          ),
        );
      },
    );
  }
}
