import 'package:inventario_test/core/database/inventory_movement_dao.dart';
import 'package:inventario_test/core/database/product_dao.dart';
import 'package:inventario_test/core/utils/delete_image.dart';
import 'package:inventario_test/core/utils/save_image_mobile.dart';
import 'package:inventario_test/src/clean_features/dtos/create_inv_mov_dto.dart';
import 'package:inventario_test/src/clean_features/dtos/create_product_dto.dart';
import 'package:inventario_test/src/clean_features/dtos/update_product_dto.dart';
import 'package:inventario_test/src/clean_features/entities/movement_entity.dart';
import 'package:inventario_test/src/clean_features/entities/product_entity.dart';

class ProductModel {

  ProductDAO productDAO;
  InventoryMovementDAO invMovDao;

  ProductModel({
    required this.productDAO,
    required this.invMovDao,
  });

  Future<ProductEntity> createProduct(CreateProductDto dto) async {

    try {
      // Guardar Imagen en dispositivo
      String imageDirectory = await saveImageMobile(dto.imageBytes!);
      // Asignar la ruta de la imagen al DTO
      dto.imageDirectory = imageDirectory;

      // Guardar producto en base de datos
      Map<String, Object?> map = dto.toMap();

      final int id = await productDAO.insertProduct(map);

      map["id"] = id;

      ProductEntity productEntity = ProductEntity.fromMap(map);

      return productEntity;

    } catch (e) {
      throw Exception(e.toString());
    }

  }

  Future<List<ProductEntity>> getProducts() async {

    try {

      List<Map<String, Object?>> productMap = await productDAO.getProducts();

      return productMap.map((e) => ProductEntity.fromMap(e),).toList();

    } catch (e) {

      throw Exception(e.toString());

    }

  }

  Future<ProductEntity> updateProduct(int id, UpdateProductDto dto) async {

    try {

      bool result = await deleteImage(dto.lastImage);

      if (!result) throw Exception("No se pudo eliminar la imagen anterior");

      // Guardar Imagen en dispositivo
      String imageDirectory = await saveImageMobile(dto.imageBytes!);
      // Asignar la ruta de la imagen al DTO
      dto.imageDirectory = imageDirectory;

      // Actualizamos el producto
      await productDAO.updateProductWithoutStock(id, dto.toMap());

      // Obtenemos el producto
      Map<String, Object?>? productMap = await productDAO.findProductById(id);

      if (productMap == null) throw Exception("No se encontró el producto");

      ProductEntity product = ProductEntity.fromMap(productMap);

      return product;

    } catch (e) {
      throw Exception(e.toString());
    }

  }

  Future<void> deleteProductById(int id, String image) async {

    try {

      bool result = await deleteImage(image);

      if (!result) throw Exception("No se pudo remover la imagen");

      await productDAO.deleteProductById(id);

    } catch (e) {
      throw Exception(e.toString());
    }

  }

  Future<List<ProductEntity>> searchProductsByName(String name) async {

    try {

      List<Map<String, Object?>> productMap = await productDAO.findProductByName(name);

      return productMap.map((e) => ProductEntity.fromMap(e),).toList();

    } catch (e) {

      throw Exception(e.toString());

    }

  }

  Future<MovementEntity> createMovement(CreateInvMovDto dto) async {

    try {

      // Crear movimiento
      final map = dto.toMap();

      final id = await invMovDao.insertMovement(map);

      // Obtener movimiento
      Map<String, Object?>? movMap = await invMovDao.findMovById(id);
      // Crear entidad del movimiento
      if (movMap == null) throw Exception("No se encontró el movimiento");

      // retornar movimiento
      return MovementEntity.fromMap(movMap);

    } catch (e) {
      throw Exception(e.toString());
    }

  }

}