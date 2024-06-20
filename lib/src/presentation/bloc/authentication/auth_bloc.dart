import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/auth_repository.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/models/image_model.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/models/user_model.dart';
import 'package:wedfluencer/src/infrastructure/navigation_service.dart';
import 'package:wedfluencer/src/presentation/bloc/authentication/auth_state.dart';
import 'package:wedfluencer/src/presentation/bloc/chat/chat_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/image/image_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/post/post_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/producerEvent/producer_events_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/userProposals/user_proposals_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/config/helper.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/login_screen.dart';
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
    on<AuthenticationSignOutEvent>(_onSignOutEvent);
  }

  final authRepo = DI.i<AuthRepository>();
  final navService = DI.i<NavigationService>();
  final producerEventsBloc = DI.i<ProducerEventsBloc>();
  final vendorServiceBloc = DI.i<VendorServiceBloc>();
  final vendorCategoryBloc = DI.i<VendorCategoryBloc>();
  final userHomeBloc = DI.i<UserHomeBloc>();
  final userProposalsBloc = DI.i<UserProposalsBloc>();
  final imageBloc = DI.i<ImageBloc>();
  final chatBloc = DI.i<ChatBloc>();
  final postBloc = DI.i<PostBloc>();

  _generalLogin({required Widget homeScreen}) {
    producerEventsBloc.add(GetProducerEvents());
    vendorServiceBloc.add(GetVendorService());
    vendorCategoryBloc.add(GetVendorCategory());
    userHomeBloc.add(GetExploreVideos());
    chatBloc.add(GetChats());
    postBloc.add(GetPosts(isImage: true, posts: []));
    emit(state.copyWith(signInLoading: false));
    navService.navigateTo((context) {
      Navigator.of(context)
          .push(WedfluencerHelper.createRoute(page: homeScreen));
    });
  }

  _onSignInEvent(AuthenticationSignInEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(signInLoading: true));
    final response = await authRepo.signIn(event.dto);
    if (response) {
      Widget homeScreen;
      switch (authRepo.user!.role) {
        case UserRole.brideGroom:
          homeScreen = const HomeScreen();
          userProposalsBloc.add(GetUserProposals(
              proposalVideos: [],
              isMe: true,
              accessToken: DI.i<AuthRepository>().accessToken,
              skip: '0'));
          _generalLogin(homeScreen: homeScreen);
        case UserRole.vendor:
          homeScreen = const VendorHomeScreen();
          userProposalsBloc.add(GetUserProposals(
              proposalVideos: [],
              isMe: false,
              accessToken: DI.i<AuthRepository>().accessToken,
              skip: '0'));
          _generalLogin(homeScreen: homeScreen);
        case UserRole.weddingProducer:
          homeScreen = const ProducerHomeScreen();
          producerEventsBloc.add(GetProducerEvents());
          _generalLogin(homeScreen: homeScreen);
        case UserRole.weddingPlanner:
          homeScreen = const HomeScreen();
          _generalLogin(homeScreen: homeScreen);
        case UserRole.loggedOut:
          navService.navigateTo((context) {
            Navigator.of(context)
                .push(WedfluencerHelper.createRoute(page: const LoginScreen()));
          });
      }
    } else {
      emit(state.copyWith(signInLoading: false));
    }
  }

  _onSignOutEvent(AuthenticationSignOutEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(signInLoading: true));
    DI.i<AuthRepository>().user = UserModel(
      id: '',
      username: '',
      firstname: '',
      lastname: '',
      roles: '',
      email: '',
      weddingDetails: null,
      phonenumber: '',
      role: UserRole.loggedOut,
      profileImage: UploadImageModel(id: '', imageUrl: ''),
    );
    navService.navigateTo((context) {
      Navigator.of(context)
          .push(WedfluencerHelper.createRoute(page: const LoginScreen()));
    });
    emit(state.copyWith(signInLoading: false));
  }
}
