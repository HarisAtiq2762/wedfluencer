import 'package:wedfluencer/src/infrastructure/data/auth_api_impl/auth_entity.dart';
import 'package:wedfluencer/src/infrastructure/data/auth_api_impl/end_point.dart';
import 'package:wedfluencer/src/infrastructure/network_service_layer/api_handler.dart';

import '../../domain/authentication/models/user_dto.dart';
import '../../resources/vendor/vendor_provider.dart';

class AuthApiImpl {
  final APIService _apiServices = APIService(baseUrl: serverUrl);
  final endPoint = AuthEndPoint();

  Future<({UserEntity userEntity, TokenEntity tokenEntity})?> signIn(
      {required UserDTO dto}) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: endPoint.signIn,
        body: dto.toMap(),
        type: RequestType.post,
      );
      if (response.sucess) {
        final userEntity = UserEntity.fromJson(response.data['user']);

        final tokenEntity = TokenEntity.fromJson(response.data['token']);
        return (userEntity: userEntity, tokenEntity: tokenEntity);
      }
      return null;
    } catch (e) {
      throw 'error';
    }
  }
}
