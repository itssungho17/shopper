import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class FileUtil {
  static final FileUtil _instance = FileUtil._internal();
  factory FileUtil() => _instance;

  FileUtil._internal();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String?> readFile(String filePath) async {
    try {
      if (filePath.startsWith('assets')) {
        return await rootBundle.loadString(filePath);
      }

      final path = await _localPath;
      final file = File('$path/$filePath');
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  
  Future<bool> writeFile(String filePath, String contents) async {
    try {
      final path = await _localPath;
      final file = File('$path/$filePath');
      file.open(mode: FileMode.write);
      file.writeAsString(contents);
      print('File written: $filePath');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
  
}
