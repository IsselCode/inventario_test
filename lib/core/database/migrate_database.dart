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
        stock INTEGER NOT NULL CHECK (stock >= 0) DEFAULT 0,
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

  static Future<void> migrateV3ToV4(Transaction txn) async {

    //* Evitar stock negativo antes de insertar
    await txn.execute('''
      CREATE TRIGGER IF NOT EXISTS trg_mov_prevent_negative_before_insert
      BEFORE INSERT ON inventoryMovement
      FOR EACH ROW
      WHEN (
        (SELECT IFNULL(stock,0) FROM product WHERE id = NEW.product_id)
        + CASE
            WHEN NEW.inv_mov_type = 'stockIn'  THEN NEW.qnty
            WHEN NEW.inv_mov_type = 'stockOut' THEN -NEW.qnty
            ELSE RAISE(ABORT, 'inv_mov_type invalido')
          END
      ) < 0
      BEGIN
        SELECT RAISE(ABORT, 'Stock insuficiente');
      END;
    ''');

    //* Ajustar stock despues de insertar
    await txn.execute('''
      CREATE TRIGGER IF NOT EXISTS trg_mov_after_insert
      AFTER INSERT ON inventoryMovement
      FOR EACH ROW
      BEGIN
        UPDATE product
        SET stock = stock + CASE
          WHEN NEW.inv_mov_type = 'stockIn'  THEN NEW.qnty
          WHEN NEW.inv_mov_type = 'stockOut' THEN -NEW.qnty
          ELSE 0
        END
        WHERE id = NEW.product_id;
      END;
    ''');

    //* Borrar un movimiento y efectos
    await txn.execute('''
      CREATE TRIGGER IF NOT EXISTS trg_mov_after_delete
      AFTER DELETE ON inventoryMovement
      FOR EACH ROW
      BEGIN
        UPDATE product
        SET stock = stock - CASE
          WHEN OLD.inv_mov_type = 'stockIn'  THEN OLD.qnty
          WHEN OLD.inv_mov_type = 'stockOut' THEN -OLD.qnty
          ELSE 0
        END
        WHERE id = OLD.product_id;
      END;
    ''');

  }

}