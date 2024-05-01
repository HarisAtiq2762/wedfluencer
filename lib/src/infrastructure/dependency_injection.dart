import 'package:get_it/get_it.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/auth_repository.dart';

import 'navigation_service.dart';

class DI {
  static GetIt i = GetIt.I;

  static setupLocator() {
    i.registerLazySingleton(() => AuthRepository());
    i.registerLazySingleton(() => NavigationService());
  }
}
