import 'package:inventario_test/core/database/product_dao.dart';
import 'package:inventario_test/core/utils/save_image_mobile.dart';
import 'package:inventario_test/src/clean_features/dtos/create_product_dto.dart';
import 'package:inventario_test/src/clean_features/entities/product_entity.dart';

class ProductModel {

  ProductDAO productDAO;

  ProductModel({
    required this.productDAO,
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

}