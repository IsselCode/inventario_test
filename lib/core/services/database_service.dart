import 'package:inventario_test/core/database/migrate_database.dart';
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
      version: 4,
      onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      },
      onCreate: (db, version) async => await _databaseTables.initTables(db),
      onUpgrade: (db, oldVersion, newVersion) async {
        // Aplica solo lo que falte, en orden
        await db.transaction((txn) async {
          var v = oldVersion;
          while (v < newVersion) {
            v++;
            switch (v) {
              case 2:
                await MigrateDatabase.migrateV1toV2(txn);
                break;
              case 3:
                await MigrateDatabase.migrateV2toV3(txn);
                break;
              case 4:
                await MigrateDatabase.migrateV3ToV4(txn);
                break;
            }
          }
        },);
      },
    );

  }

  Database get db => _db;

}
