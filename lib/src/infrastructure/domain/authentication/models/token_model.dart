import '../../../data/auth_api_impl/auth_entity.dart';

class TokenModel {
  final String accessToken;
  final String refreshToken;

  const TokenModel({required this.accessToken, required this.refreshToken});

  factory TokenModel.fromEntity(TokenEntity entity) {
    return TokenModel(
        accessToken: entity.accessToken, refreshToken: entity.refreshToken);
  }
}
