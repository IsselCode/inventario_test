import 'package:flutter/material.dart';
import 'package:inventario_test/core/app/enums.dart';
import 'package:inventario_test/core/services/navigation_service.dart';
import 'package:inventario_test/core/services/toast_service.dart';
import 'package:inventario_test/src/clean_features/dtos/create_inv_mov_dto.dart';
import 'package:inventario_test/src/clean_features/dtos/create_product_dto.dart';
import 'package:inventario_test/src/clean_features/dtos/update_product_dto.dart';
import 'package:inventario_test/src/clean_features/entities/movement_entity.dart';
import 'package:inventario_test/src/clean_features/entities/product_entity.dart';
import 'package:inventario_test/src/clean_features/inputs/add_new_product_input_model.dart';
import 'package:inventario_test/src/clean_features/inputs/edit_product_input.dart';
import 'package:inventario_test/src/models/product_model.dart';
import 'package:provider/provider.dart';

import '../../../core/errors/exceptions.dart';

class InventoryController extends ChangeNotifier {

  ProductModel model;
  NavigationService navigationService;
  ToastService toastService;

  InventoryController({
    required this.model,
    required this.navigationService,
    required this.toastService,
  });

  List<ProductEntity> products = <ProductEntity>[];
  List<ProductEntity> productsShown = <ProductEntity>[];

  bool isLoaded = false;

  Future<void> createNewProduct(AddNewProductInputModel anpim) async {

    try {
      // Crear el DTO
      CreateProductDto dto = CreateProductDto.fromInput(anpim);
      // Comunicarse con el módelo
      ProductEntity newProduct = await model.createProduct(dto);
      // Añadir el nuevo producto a la lista
      products.add(newProduct);
      // Notificar los cambios
      notifyListeners();
      // Navegar a la pantalla anterior
      navigationService.goBack();
    } on AppException catch (e) {
      // Mostrar el error
      toastService.error(e.message);
    }

  }

  Future<void> getProducts() async {
    try {
      // Si ya fueron cargados, no hacer nada
      if (isLoaded) return;
      // Obtener los productos
      List<ProductEntity> results = await model.getProducts();
      // Asignarlos a los productos ya cargados y mostrados
      products = results;
      productsShown = results;
      // Indicar que los productos ya han sido cargados
      isLoaded = true;
      // Notificar los cambios
      notifyListeners();
      // Mostrar mensaje indicativo (temporal)
      toastService.success("Productos cargados");
    } catch (e) {
      toastService.error(e.toString());
    }
  }

  Future<void> updateProduct(int id, EditProductInput epi) async {

    try {
      UpdateProductDto dto = UpdateProductDto.fromInput(epi);
      ProductEntity updatedProduct = await model.updateProduct(id, dto);
      int productIndex = products.indexWhere((element) => element.id == id,);
      products[productIndex] = updatedProduct;
      notifyListeners();
      navigationService.goBack();
      toastService.success("Producto Actualizado");
    } catch (e) {
      toastService.error(e.toString());
    }

  }

  Future<void> deleteProductById(int id, String image) async {

    try {

      await model.deleteProductById(id, image);

      products.removeWhere((element) => element.id == id,);

      notifyListeners();

      toastService.success("Producto eliminado");

    } catch(e) {
      toastService.error(e.toString());
    }

  }

  Future<void> searchProductByName(String name) async {

    try {

      productsShown = await model.searchProductsByName(name);
      notifyListeners();

    } catch (e) {
      toastService.error(e.toString());
    }

  }

  void showAllProducts() {
    productsShown = products;
    notifyListeners();
  }

  /// MOVIMIENTOS
  List<MovementEntity> movements = <MovementEntity>[];
  bool movLoaded = false;

  Future<void> createMovement(ProductEntity product, int delta, InventoryMovementType type) async {

    try {
      // Crear DTO
      CreateInvMovDto dto = CreateInvMovDto(
          productId: product.id,
          productName: product.title,
          type: type,
          qnty: delta,
          priceAt: product.price
      );
      // Crear el movimiento
      MovementEntity movementEntity = await model.createMovement(dto);
      // Agregar el movimiento a la lista de movimientos
      movements.add(movementEntity);
      // Ajustar los cambios en el producto
      int indexProduct = products.indexWhere((element) => element.id == product.id,);
      products[indexProduct].stock += delta; // Pasamos el valor no absoluto
      // notificar cambios y mostramos todos los productos para aplicar cambios
      showAllProducts();
    } catch (e) {
      toastService.error(e.toString());
    }

  }

  Future<void> getMovements() async {

    try {

      if (movLoaded) return ;
      movements = await model.getMovements();
      movLoaded = true;
      notifyListeners();

    } catch (e) {

      toastService.error("Error al cargar los movimientos");

    }

  }

  Future<void> deleteMovById(int id, int productId, InventoryMovementType type, int qnty) async {

    try {

      // Remover producto desde el modelo
      await model.deleteMovById(id);
      // Remover el producto de la lista
      movements.removeWhere((element) => element.id == id,);
      // Ajusta el stock del producto
      int indexProduct = products.indexWhere((element) => element.id == productId,);
      if (type == InventoryMovementType.stockIn) {
        products[indexProduct].stock -= qnty;
      } else {
        products[indexProduct].stock += qnty;
      }
      // Mostrar todos los productos para asignar y notificar los cambios correctamente
      showAllProducts();
      toastService.success("Movimiento eliminado");
    } catch (e) {
      toastService.error(e.toString());
    }

  }

}