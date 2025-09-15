import 'package:sqflite/sqflite.dart';

// Product Data Access Object | objeto de acceso a datos
// Se encarga de todas las operaciones CRUD
class ProductDAO {
  final Database db;
  ProductDAO({required this.db});

  // Products
  Future<List<Map<String, Object?>>> getProducts() => db.query("product");

  Future<Map<String, Object?>?> findProductById(int id) async {
    final result = await db.query(
      "product",
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, Object?>>> findProductByName(String name) {
    // COLLATE NOCASE le dice a SQLite que ignore mayúsculas y minúsculas
    // al comparar los textos en esa consulta
    return db.query(
      "product",
      where: "title LIKE ? COLLATE NOCASE",
      whereArgs: ["%$name%"],
      orderBy: "title ASC", //
    );
  }

  Future<int> insertProduct(Map<String, Object?> values) => db.insert("product", values);

  Future<int> updateProductWithoutStock(int id, Map<String, Object?> values) {
    final updatedValues = Map<String, Object?>.from(values)..remove('stock');
    if (updatedValues.isEmpty) return Future.value(0);
    return db.update(
      "product",
      updatedValues,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateProductStock(int id, int newStock) {
    return db.update(
      "product",
      {"stock": newStock},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> deleteProductById(int id) => db.delete("product", where: "id = ?", whereArgs: [id]);
}
