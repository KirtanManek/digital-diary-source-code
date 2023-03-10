import 'dart:io';
import 'package:digitaldiary/views/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
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

  Future<User> validatePassword(String userEmail, String password) async {
    Database db = await initDatabase();
    var data = await db.rawQuery(
        'SELECT * FROM MST_User WHERE MST_User.UserEmail = ?', [userEmail]);

    // below if statement is used for debugging
    if (kDebugMode) {
      print(data[0]['UserPassword'].toString());
      print(password.toString().compareTo(data[0]['UserPassword'].toString()) == 0);
      print(password);
    }

    // return password.toString().compareTo(data[0]['UserPassword'].toString()) == 0;
    return User.fromMap(data[0]);
  }

  Future<int?> insertDataIntoDatabase(Map<String, dynamic> data) async {
    Database db = await initDatabase();
    int id = await db.insert('MST_User', data);
    if (kDebugMode) {
      print(id);
    }
    return id;
  }
}
