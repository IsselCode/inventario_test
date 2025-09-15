import 'package:sqflite/sqflite.dart';

class DatabaseTables {

  Future<void> initTables(Database db) async {

    await db.transaction((txn) async {
      await _products(txn);
      await _inventoryMovements(txn);
    },);

  }

  Future<void> _products(Transaction txn) async {
    //! Crear tabla
    await txn.execute('''
      CREATE TABLE product(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        price REAL NOT NULL,
        stock INTEGER NOT NULL DEFAULT 0, 
        image TEXT NOT NULL
      );
    ''');
    //! Crear Indice
    await txn.execute("CREATE INDEX idx_product_title ON product(title)");
  }

  Future<void> _inventoryMovements(Transaction txn) async {
    await txn.execute('''
      CREATE TABLE inventoryMovement(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER NOT NULL,
        product_name TEXT NOT NULL,
        inv_mov_type TEXT NOT NULL,
        qnty INTEGER NOT NULL,
        price_at REAL NOT NULL,
        create_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now'))
      );
    ''');
  }

}