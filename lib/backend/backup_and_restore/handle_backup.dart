import 'dart:io';

import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HandleBackup {
  String hiveLocation;
  String backupLocation;
  final BuildContext context;

  HandleBackup(
    this.context, {
    this.hiveLocation = "hive",
    this.backupLocation = "my_manga_backups",
  });

  static Directory fromUri(Directory currentDir, String pathToAdd) {
    return Directory.fromUri(Uri.parse(currentDir.uri.toString() + pathToAdd));
  }

  static dirChecker(Directory dir) async {
    await for (var x in dir.list(recursive: true, followLinks: true)) {
      print(x.toString());
    }
  }

  static dateJoinerZip() {
    var date = DateTime.now();
    return "${date.year}_${date.month}_${date.day}_${date.hour}_${date.minute}_${date.second}" +
        ".zip";
  }

  Future<void> initBackup() async {
    var storagePermission = await Permission.storage.request();
    if (storagePermission.isGranted) {
      String path = await FilesystemPicker.open(
          context: context, rootDirectory: Directory("/"));
      _createBackup(path);
    } else {
      //todo: show alert dialog
    }
  }

  Future<void> _createBackup(String path) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    // print(appDocDir.uri);

    Directory hiveDir = fromUri(appDocDir, hiveLocation);
    // dirChecker(hiveDir);

    Directory backupDir = fromUri(Directory(path), backupLocation);
    if (!backupDir.existsSync()) {
      backupDir.createSync();
    }

    try {
      final zipFile = File(backupDir.path + "/" + dateJoinerZip());
      await ZipFile.createFromDirectory(
        sourceDir: hiveDir,
        zipFile: zipFile,
        recurseSubDirs: true,
      );
    } catch (e) {
      print("Error:" + e);
    }

    // dirChecker(appDocDir);
  }
}
