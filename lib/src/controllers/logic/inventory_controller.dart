import 'package:flutter/material.dart';
import 'package:inventario_test/core/services/navigation_service.dart';
import 'package:inventario_test/core/services/toast_service.dart';
import 'package:inventario_test/src/clean_features/dtos/create_product_dto.dart';
import 'package:inventario_test/src/clean_features/dtos/update_product_dto.dart';
import 'package:inventario_test/src/clean_features/entities/product_entity.dart';
import 'package:inventario_test/src/clean_features/inputs/add_new_product_input_model.dart';
import 'package:inventario_test/src/clean_features/inputs/edit_product_input.dart';
import 'package:inventario_test/src/models/product_model.dart';

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
    } catch (e) {
      // Mostrar el error
      toastService.error(e.toString());
    }

  }

  Future<void> getProducts() async {
    try {
      // Si ya fueron cargados, no hacer nada
      if (isLoaded) return;
      // Obtener los productos
      products = await model.getProducts();
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

}