import 'dart:io';

import 'file_upload_provider.dart';

class FileUploadRepository {
  final fileUploadProvider = FileUploadProvider();

  Future<Map<String, String>> uploadFile({
    required File file,
    required String title,
    required String description,
    required bool isVideo,
    required String containerName,
  }) =>
      fileUploadProvider.uploadFileToBlob(
        file: file,
        containerName: containerName,
        isVideo: isVideo,
      );
}
