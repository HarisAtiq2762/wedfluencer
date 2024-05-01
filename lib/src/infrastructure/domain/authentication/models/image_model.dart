import '../../../data/auth_api_impl/auth_entity.dart';

class UploadImageModel {
  final String id;
  final String imageUrl;

  UploadImageModel({required this.id, required this.imageUrl});
  factory UploadImageModel.fromEntity(UploadImageEntity entity) {
    return UploadImageModel(id: entity.id, imageUrl: entity.url);
  }
}
