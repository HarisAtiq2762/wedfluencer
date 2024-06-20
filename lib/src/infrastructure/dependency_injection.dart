import 'package:get_it/get_it.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/auth_repository.dart';
import 'package:wedfluencer/src/presentation/bloc/chat/chat_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/createEvent/create_event_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/createVendor/create_vendor_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/image/image_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/makePayment/payment_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/post/post_bloc.dart';

import '../presentation/bloc/createProposal/create_proposal_bloc.dart';
import '../presentation/bloc/producerEvent/producer_events_bloc.dart';
import '../presentation/bloc/userHome/user_home_bloc.dart';
import '../presentation/bloc/userProposals/user_proposals_bloc.dart';
import '../presentation/bloc/vendorCategory/vendor_category_bloc.dart';
import '../presentation/bloc/vendorService/vendor_service_bloc.dart';
import 'navigation_service.dart';

class DI {
  static GetIt i = GetIt.I;

  static setupLocator() {
    i.registerLazySingleton(() => AuthRepository());
    i.registerLazySingleton(() => NavigationService());
    i.registerLazySingleton(() => ProducerEventsBloc());
    i.registerLazySingleton(() => VendorServiceBloc());
    i.registerLazySingleton(() => VendorCategoryBloc());
    i.registerLazySingleton(() => UserHomeBloc());
    i.registerLazySingleton(() => CreateEventBloc());
    i.registerLazySingleton(() => UserProposalsBloc());
    i.registerLazySingleton(() => CreateProposalBloc());
    i.registerLazySingleton(() => ImageBloc());
    i.registerLazySingleton(() => CreateVendorBloc());
    i.registerLazySingleton(() => ChatBloc());
    i.registerLazySingleton(() => PaymentBloc());
    i.registerLazySingleton(() => PostBloc());
  }
}
