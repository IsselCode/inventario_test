import 'package:sqflite/sqflite.dart';

class InventoryMovementDAO {
  final Database db;
  InventoryMovementDAO({required this.db});

  // Movimientos de inventario
  Future<List<Map<String, Object?>>> getMovements() => db.query("inventoryMovement");

  Future<int> insertMovement(Map<String, Object?> values) => db.insert("inventoryMovement", values);

  Future<int> deleteMovementById(int id) => db.delete("inventoryMovement", where: "id = ?", whereArgs: [id]);

}
