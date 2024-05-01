import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/navigation_service.dart';
import 'package:wedfluencer/src/presentation/bloc/authentication/auth_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/authentication/auth_state.dart';
import 'package:wedfluencer/src/presentation/bloc/createProposal/create_proposal_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/theme/theme_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/translation/translation_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/user/user_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/userHome/user_home_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/userProposals/user_proposals_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/vendorCategory/vendor_category_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/vendorService/vendor_service_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/config/routes.dart';
import 'package:wedfluencer/src/presentation/ui/config/theme.dart';
import 'package:wedfluencer/src/presentation/ui/screens/splash/splash_screen.dart';
import 'infrastructure/localization/global_translation.dart';

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
            BlocProvider(create: (context) => UserBloc()),
            BlocProvider(
              lazy: false,
              create: (context) => VendorServiceBloc()..add(GetVendorService()),
            ),
            BlocProvider(
              lazy: false,
              create: (context) =>
                  VendorCategoryBloc()..add(GetVendorCategory()),
            ),
            BlocProvider(
                create: (context) =>
                    AuthenticationBloc(AuthenticationState.initial())),
            BlocProvider(create: (context) => UserHomeBloc()),
            BlocProvider(create: (context) => UserProposalsBloc()),
            BlocProvider(create: (context) => CreateProposalBloc()),
          ],
          child: OverlaySupport(
            child: MaterialApp(
              locale: state.locale,
              navigatorKey: DI.i<NavigationService>().navigationKey,
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
