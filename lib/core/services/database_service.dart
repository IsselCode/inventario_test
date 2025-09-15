import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import '../database/database_tables.dart';

class DatabaseService {

  late Database _db;
  final DatabaseTables _databaseTables = DatabaseTables();

  Future<void> loadDatabase() async {

    final dir = await getDatabasesPath();
    final path = p.join(dir, "app.db");

    _db = await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      },
      onCreate: (db, version) async => await _databaseTables.initTables(db),
    );

  }

  Database get db => _db;

}

