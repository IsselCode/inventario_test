import 'package:sqflite/sqflite.dart';

class InventoryMovementDAO {
  final Database db;
  InventoryMovementDAO({required this.db});

  // Movimientos de inventario
  Future<List<Map<String, Object?>>> getMovements() => db.query("inventoryMovement");

  Future<Map<String, Object?>?> findMovById(int id) async {
    final result = await db.query(
      "inventoryMovement",
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> insertMovement(Map<String, Object?> values) => db.insert("inventoryMovement", values);

  Future<int> deleteMovementById(int id) => db.delete("inventoryMovement", where: "id = ?", whereArgs: [id]);

}
