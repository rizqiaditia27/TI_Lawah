import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:ti_lawah/models/Surah.dart';
import 'package:ti_lawah/models/Ayat.dart';

class DBHelper {
  late Database db;

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "thehafiz.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data =
          await rootBundle.load(join("assets/database/", "thehafiz-app.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    }
// open the database
    db = await openDatabase(path, version: 1);

    return db;
  }

  Future<List<Surah>> getSurah() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> datas = await db.query("surahName");
    final surahName = datas.map((e) => Surah.fromMap(e)).toList();

    return surahName;
  }

  Future<List<Ayat>> getAyat(int idSurah) async {
    final Database db = await initDB();
    final List<Map<String, Object?>> datas = await db.rawQuery(
        "SELECT id,verseId,ayahText,indoText FROM quran_id WHERE surahId = $idSurah");
    final ayat = datas.map((e) => Ayat.fromMap(e)).toList();

    return ayat;
  }
}
