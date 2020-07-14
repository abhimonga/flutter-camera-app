import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

// import 'package:path_provider/path_provider.dart';

class Storage {
  static Future<String> getDirPath() async {
final Directory extD=await getExternalStorageDirectory();
final String dirPath='${extD.path}/Pictures';
await Directory(dirPath).create(recursive: true);
return '$dirPath';

  }

  static Future<String> getFilePath() async {
    String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
    final String dirPath = await getDirPath();
    return '$dirPath/${timestamp()}.jpg';
  }

  static Future<List<String>> get getFilePaths async {
    final List<String> paths = [];
    var directory = Directory(await getDirPath());
    var completer = Completer<List<String>>();
    var listener = directory.list(recursive: false);
    listener.listen((file) {
      if (file is File) {
        paths.insert(0, file.path);
      }
    }, onDone: () => completer.complete(paths));

    return completer.future;
  }
}
