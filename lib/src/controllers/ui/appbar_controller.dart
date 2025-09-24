import 'package:flutter/material.dart';
import 'package:inventario_test/core/services/navigation_service.dart';
import 'package:inventario_test/src/controllers/logic/inventory_controller.dart';
import 'package:inventario_test/src/views/add_new_product_view.dart';

class AppbarController extends ChangeNotifier {

  NavigationService navigationService;
  InventoryController inventoryController;

  AppbarController({
    required this.navigationService,
    required this.inventoryController,
  });

  TextEditingController searchController = TextEditingController();
  bool searching = false;

  //! AppBar

  Future<void> onSearch(String value) async {

    if (value.isNotEmpty){
      await inventoryController.searchProductByName(value);
    }

  }

  Future<void> onChangedSearch(String value) async {

    if (searchController.text.isEmpty) {
      searching = false;
      inventoryController.showAllProducts();
    } else {
      searching = true;
    }
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    searching = false;
    inventoryController.showAllProducts();
    notifyListeners();
  }

  void navigateToAddNewProduct() => navigationService.navigateTo(AddNewProductView());
}