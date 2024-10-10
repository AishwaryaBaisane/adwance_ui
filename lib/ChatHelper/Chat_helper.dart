
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelper
{
  static DbHelper dbHelper = DbHelper._();

  DbHelper._();

  Database? _db;

  Future<Database> get database async => _db ?? await initDatabase();

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'Platform.db');

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        String sql = '''CREATE TABLE Platform(
         Name TEXT,
         Phone TEXT,
         Chat TEXT
        );'''; // Removed the extra comma
        await db.execute(sql);
      },
    );
    return _db!;
  }


  Future<void> insertData({required String Name,required String Phone,required String Chat}) async {
    Database? db = await database;
    String sql = '''INSERT INTO Platform(Name, Phone, Chat)
    VALUES (?, ?, ?);''';
    List<dynamic> args = [Name,Phone,Chat];
    await db.rawInsert(sql, args);
  }

  Future readData()
  async {
    Database? db = await database;
    String sql ='''
    SELECT * FROM Platform
    ''';
    return await db!.rawQuery(sql);
  }


}