import 'package:sqflite/sqflite.dart';

class MigrateDatabase {

  static Future<void> migrateV1toV2(Transaction txn) async {

    // Crear indice UNICO
    await txn.execute("CREATE UNIQUE INDEX IF NOT EXISTS idx_product_title_unique ON product(title COLLATE NOCASE);");

  }

  static Future<void> migrateV2toV3(Transaction txn) async {
    // Renombrar tabla vieja
    await txn.execute("ALTER TABLE product RENAME TO product_old;");
    // Reconstruir tabla
    await txn.execute('''
      CREATE TABLE product(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL UNIQUE COLLATE NOCASE,
        description TEXT NOT NULL CHECK (length(trim(description)) >= 10),
        price REAL NOT NULL CHECK (price > 0),
        stock INTEGER NOT NULL DEFAULT 0,
        image TEXT NOT NULL
      );
    ''');
    // Copiar los datos
    await txn.execute('''
      INSERT INTO product (id, title, description, price, stock, image)
      SELECT id, title, description, price, stock, image
      FROM product_old;
    ''');
    // Eliminar tabla vieja
    txn.execute("DROP TABLE product_old;");
    // Eliminar el viejo indice único
    txn.execute("DROP INDEX IF EXISTS idx_product_title_unique;");
  }

}