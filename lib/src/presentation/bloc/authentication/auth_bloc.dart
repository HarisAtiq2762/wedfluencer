import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/auth_repository.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/models/user_model.dart';
import 'package:wedfluencer/src/infrastructure/navigation_service.dart';
import 'package:wedfluencer/src/presentation/bloc/authentication/auth_state.dart';
import 'package:wedfluencer/src/presentation/bloc/producerEvent/producer_events_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/config/helper.dart';
import 'package:wedfluencer/src/presentation/ui/screens/brideGroomFlow/home.dart';
import 'package:wedfluencer/src/presentation/ui/screens/producerFlow/producer_home.dart';
import 'package:wedfluencer/src/presentation/ui/screens/vendorFlow/vendor_home.dart';

import '../../../infrastructure/dependency_injection.dart';
import '../userHome/user_home_bloc.dart';
import '../vendorCategory/vendor_category_bloc.dart';
import '../vendorService/vendor_service_bloc.dart';
import 'auth_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(super.initialState) {
    on<AuthenticationSignInEvent>(_onSignInEvent);
  }

  final authRepo = DI.i<AuthRepository>();
  final navService = DI.i<NavigationService>();

  _onSignInEvent(AuthenticationSignInEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(signInLoading: true));
    final response = await authRepo.signIn(event.dto);
    if (response) {
      Widget homeScreen;
      navService.navigateTo((context) {
        BlocProvider.of<ProducerEventsBloc>(context).add(GetProducerEvents());
        BlocProvider.of<VendorServiceBloc>(context).add(GetVendorService());
        BlocProvider.of<VendorCategoryBloc>(context).add(GetVendorCategory());
        BlocProvider.of<UserHomeBloc>(context).add(GetExploreVideos());
      });
      switch (authRepo.user!.role) {
        case UserRole.brideGroom:
          homeScreen = const HomeScreen();
        case UserRole.vendor:
          homeScreen = const VendorHomeScreen();
        case UserRole.weddingProducer:
          homeScreen = const ProducerHomeScreen();
          navService.navigateTo((context) {
            BlocProvider.of<ProducerEventsBloc>(context)
                .add(GetProducerEvents());
          });
        case UserRole.weddingPlanner:
          homeScreen = const HomeScreen();
      }
      emit(state.copyWith(signInLoading: false));
      navService.navigateTo((context) {
        Navigator.of(context)
            .push(WedfluencerHelper.createRoute(page: homeScreen));
      });
    } else {
      emit(state.copyWith(signInLoading: false));
    }
  }
}
