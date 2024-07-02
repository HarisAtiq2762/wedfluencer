import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/navigation_service.dart';
import 'package:wedfluencer/src/presentation/bloc/authentication/auth_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/authentication/auth_state.dart';
import 'package:wedfluencer/src/presentation/bloc/chat/chat_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/createEvent/create_event_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/createProposal/create_proposal_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/createVendor/create_vendor_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/image/image_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/makePayment/payment_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/post/post_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/producerEvent/producer_events_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/producerPayment/producer_payment_bloc.dart';
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
                create: (context) =>
                    AuthenticationBloc(AuthenticationState.initial())),
            BlocProvider(create: (context) => DI.i<UserHomeBloc>()),
            BlocProvider(create: (context) => DI.i<UserProposalsBloc>()),
            BlocProvider(create: (context) => DI.i<CreateProposalBloc>()),
            BlocProvider(create: (context) => DI.i<ProducerEventsBloc>()),
            BlocProvider(create: (context) => DI.i<CreateEventBloc>()),
            BlocProvider(create: (context) => DI.i<VendorServiceBloc>()),
            BlocProvider(create: (context) => DI.i<VendorCategoryBloc>()),
            BlocProvider(create: (context) => DI.i<ImageBloc>()),
            BlocProvider(create: (context) => DI.i<CreateVendorBloc>()),
            BlocProvider(create: (context) => DI.i<ChatBloc>()),
            BlocProvider(create: (context) => DI.i<PaymentBloc>()),
            BlocProvider(create: (context) => DI.i<PostBloc>()),
            BlocProvider(create: (context) => DI.i<ProducerPaymentsBloc>()),
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
