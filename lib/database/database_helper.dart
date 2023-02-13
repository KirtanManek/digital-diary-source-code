import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase{
  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'digital-diary.db');
    return await openDatabase(
      databasePath,
      version: 2,
    );
  }

  Future<void> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "digital-diary.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data =
      await rootBundle.load(join('assets/database', 'digital-diary.db'));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    }
  }

  Future<List<Map<String, Object?>>> getDataFromUserTable() async {
    Database db = await initDatabase();
    List<Map<String, Object?>> data = await db.rawQuery('SELECT * FROM MST_User');
    if (kDebugMode) {
      print("Data Length ::: ${data.length}");
    }
    return data;
  }

  Future<String> validatePassword(String userEmail) async {
    Database db = await initDatabase();

    List<Map<String, Object?>> data = await db.rawQuery('SELECT UserPassword FROM MST_User WHERE MST_User.UserEmail = ?',[userEmail]);
    if (kDebugMode) {
      print(data[0]['UserPassword'].toString());
    }
    return data[0]['UserPassword'].toString();
  }
}