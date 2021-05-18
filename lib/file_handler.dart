import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class FileHandler {
  String fileName;

  FileHandler(this.fileName);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  /// todo: for testing purposes
  static Future<String> loadStringAsset(String assetLocation) async {
    return await rootBundle.loadString('$assetLocation');
  }
}
