import 'package:flutter/material.dart';
import 'package:inventario_test/core/services/navigation_service.dart';
import 'package:inventario_test/core/services/toast_service.dart';
import 'package:inventario_test/src/clean_features/dtos/create_product_dto.dart';
import 'package:inventario_test/src/clean_features/entities/product_entity.dart';
import 'package:inventario_test/src/clean_features/inputs/add_new_product_input_model.dart';
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

  Future<void> createNewProduct (AddNewProductInputModel anpim) async {

    try {
      // Crear el DTO
      CreateProductDto dto = CreateProductDto.fromInput(anpim);
      // Comunicarse con el módelo
      ProductEntity newProduct = await model.createProduct(dto);
      // Añadir el nuevo producto a la lista
      products.add(newProduct);
      // Navegar a la pantalla anterior
      navigationService.goBack();
    } catch (e) {
      // Mostrar el error
      toastService.error(e.toString());
    }

  }

}