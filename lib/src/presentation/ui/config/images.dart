import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import '../templates/debug_helper.dart';

class ImageProcessing {
  static Future<List<String>> convertToBase64Images(
      List<XFile> imageAssets) async {
    // List<Asset> imageAssets) async {

    List<String> images = [];

    for (var i = 0; i < imageAssets.length; i++) {
      final compressedImage = await compressFile(File(imageAssets[i].path));
      List<int> imageBytes = await compressedImage.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      images.add(base64Image);

      // final imageFile =
      //     await FlutterAbsolutePath.getAbsolutePath(imageAssets[i].identifier);

      // var file = newFile.File(imageFile);
      // file = await compressFile(file);
      // var base64Image = base64Encode(file.readAsBytesSync());
      // images.add(base64Image);
    }

    return images;
  }
}

Future<File> compressFile(File file) async {
  try {
    final bytes = file.readAsBytesSync().lengthInBytes;
    var kb = bytes / 1024;
    var mb = kb / 1024;
    DebugHelper.printAll('Before Compress Size: $mb');

    if (mb > 1) {
      final quality = (100 / mb).floor();

      final filePath = file.absolute.path;
      DebugHelper.printAll('File Path: $filePath');

      final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
      final splitted = filePath.substring(0, (lastIndex));
      final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
      var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        outPath,
        quality: quality,
      );
      final bytes = result!.readAsBytesSync().lengthInBytes;
      kb = bytes / 1024;
      mb = kb / 1024;

      file = result;
    }

    return file;
  } catch (e) {
    return file;
  }
}

bool isImageLesserThanDefinedSize(File file) {
  final bytes = file.readAsBytesSync().lengthInBytes;
  var kb = bytes / 1024;
  var mb = kb / 1024;

  if (mb < 6) {
    return true;
  } else {
    return false;
  }
}
