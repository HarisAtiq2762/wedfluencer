import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/models/token_model.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/models/user_dto.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/models/user_model.dart';
import 'package:wedfluencer/src/infrastructure/navigation_service.dart';

import '../../data/auth_api_impl/auth_api_impl.dart';

class AuthRepository {
  final AuthApiImpl authImpl = AuthApiImpl();

  TokenModel? _token;
  UserModel? user;

  bool get isUserLogin => user != null;

  String get accessToken => _token!.accessToken;

  Future<bool> signIn(UserDTO dto) async {
    try {
      final response = await authImpl.signIn(dto: dto);
      if (response != null) {
        _token = TokenModel.fromEntity(response.tokenEntity);
        user = UserModel.fromEntity(response.userEntity);

        DI.i<NavigationService>().showSnackBar(message: 'Login successful');
        return true;
      } else {
        DI
            .i<NavigationService>()
            .showSnackBar(message: 'Please check your login credentials');
        return false;
      }
    } catch (e) {
      DI.i<NavigationService>().showSnackBar(message: e.toString());
      return false;
    }
  }
}
