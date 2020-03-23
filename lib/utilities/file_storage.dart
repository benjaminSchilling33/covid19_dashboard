/*
covid19_dashboard
This is the dart file containing the FileStorage class needed to load the cached datasets and the etags.
SPDX-License-Identifier: GPL-2.0-only
Copyright (C) 2019 Benjamin Schilling
*/

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class FileStorage {
  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  ///InfectedFile
  static Future<bool> get infectedFileAvailable async {
    final path = await localPath;
    return File('$path/infected.csv').exists();
  }

  static Future<File> get localInfectedFile async {
    final path = await localPath;
    return File('$path/infected.csv');
  }

  static Future<File> writeInfectedFile(String data) async {
    final file = await localInfectedFile;

    // Write the file
    return file.writeAsString('$data', mode: FileMode.write);
  }

  static Future<String> readInfectedFile() async {
    try {
      final file = await localInfectedFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If we encounter an error, return 0
      return "";
    }
  }

  /// Recovered File
  static Future<bool> get recoveredFileAvailable async {
    final path = await localPath;
    return File('$path/recovered.csv').exists();
  }

  static Future<File> get localRecoveredFile async {
    final path = await localPath;
    return File('$path/recovered.csv');
  }

  static Future<File> writeRecoveredFile(String data) async {
    final file = await localRecoveredFile;

    // Write the file
    return file.writeAsString('$data', mode: FileMode.write);
  }

  static Future<String> readRecoveredFile() async {
    try {
      final file = await localRecoveredFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If we encounter an error, return 0
      return "";
    }
  }

  ///DeceasedFile
  static Future<bool> get deceasedFileAvailable async {
    final path = await localPath;
    return File('$path/deceased.csv').exists();
  }

  static Future<File> get localDeceasedFile async {
    final path = await localPath;
    return File('$path/deceased.csv');
  }

  static Future<File> writeDeceasedFile(String data) async {
    final file = await localDeceasedFile;

    // Write the file
    return file.writeAsString('$data', mode: FileMode.write);
  }

  static Future<String> readDeceasedFile() async {
    try {
      final file = await localDeceasedFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If we encounter an error, return 0
      return "";
    }
  }

  /// ETag File
  static Future<bool> get etagFileAvailable async {
    final path = await localPath;
    return File('$path/etags.txt').exists();
  }

  static Future<File> get localEtagFile async {
    final path = await localPath;
    return File('$path/etags.txt');
  }

  static Future<File> writeEtagFile(String data) async {
    final file = await localEtagFile;

    // Write the file
    return file.writeAsString('$data', mode: FileMode.write);
  }

  static Future<String> readEtagFile() async {
    try {
      final file = await localEtagFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If we encounter an error, return 0
      return "";
    }
  }

  static Future<String> getValueOfEtag(String category) async {
    String s = await readEtagFile();
    if (!kReleaseMode) {
      print('s: $s');
    }
    List<String> categories = s.split('&');
    if (!kReleaseMode) {
      print('Categories: $categories');
    }
    String cat =
        categories.firstWhere((element) => element.startsWith(category));
    if (!kReleaseMode) {
      print('cat: $cat');
    }
    return cat.split(':')[1];
  }

  static void writeEtagFileWithValues(
      String etagInfected, String etagRecovered, String etagDeceased) {
    if (!kReleaseMode) {
      print(
          'etagInfected:$etagInfected&etagRecovered:$etagRecovered&etagDeceased:$etagDeceased');
    }
    writeEtagFile(
        'etagInfected:$etagInfected&etagRecovered:$etagRecovered&etagDeceased:$etagDeceased');
  }
}
