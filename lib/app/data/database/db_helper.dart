import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._singleton();
  static DbHelper? _dbHelper;

  static Database? _database;

  factory DbHelper() {
    return _dbHelper ??= DbHelper._singleton();
  }

  Future<Database> init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'logcashflow.db');

    return _database ??=
        await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    //buat tabel timbang
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY NOT NULL,
        username VARCHAR(255) NOT NULL,
        password VARCHAR(255) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE cashflow(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        users_id INTEGER NOT NULL,
        type INTEGER NOT NULL,
        date DATE NOT NULL,
        value INTEGER NOT NULL,
        description TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    var defaultUsers = {
      'username': 'user',
      'password': sha512.convert(utf8.encode('user')).toString()
    };
    await db.insert('users', defaultUsers);
  }

  Future<int> insert(String table, Map<String, dynamic> object) async {
    var db = await init();
    int result = await db.insert(table, object);
    return result;
  }

  Future<int> update(String table, Map<String, dynamic> object, int id) async {
    var db = await init();
    int result = await db.update(table, object, where: 'id=?', whereArgs: [id]);
    return result;
  }

  Future<List<Map<String, dynamic>>> selectAll(String table) async {
    var db = await init();
    var result = await db.query(table);
    return result;
  }

  Future<int> delete(String table, int id) async {
    var db = await init();
    var result = db.delete(table, where: 'id=?', whereArgs: [id]);
    return result;
  }

  Future<List<Map<String, dynamic>>> selectQuery(String query,
      [List<Object?>? arguments]) async {
    var db = await init();
    var result = await db.rawQuery(query, arguments);
    return result;
  }
}
