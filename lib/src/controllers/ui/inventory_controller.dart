import 'package:flutter/material.dart';
import 'package:inventario_test/core/services/navigation_service.dart';
import 'package:inventario_test/src/views/add_new_product_view.dart';

class InventoryController extends ChangeNotifier {

  NavigationService navigationService;

  InventoryController({
    required this.navigationService
  });

  TextEditingController searchController = TextEditingController();
  bool searching = false;

  List<dynamic> showProducts = [];

  //! AppBar

  Future<void> onSearch(String value) async {

  }

  Future<void> onChangedSearch(String value) async {
    searchController.text.isEmpty ? searching = false : searching = true;
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    searching = false;
    notifyListeners();
  }

  void navigateToAddNewProduct() => navigationService.navigateTo(AddNewProductView());

  //! Body

}