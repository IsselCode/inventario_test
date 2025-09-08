import 'package:flutter/material.dart';
import 'package:inventario_test/src/clean_features/entities/product_entity.dart';
import 'package:inventario_test/src/clean_features/widgets/filled_button_widget.dart';
import 'package:inventario_test/src/clean_features/widgets/forms/add_product_form.dart';
import 'package:inventario_test/src/views/pages/edit_product_page.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../clean_features/widgets/forms/edit_product_form.dart';

class ProductView extends StatelessWidget {

  final ProductEntity productEntity;

  ProductView({
    super.key,
    required this.productEntity
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Column(
        children: [
          //* Toggle Button

          //* Pages
          Expanded(
            child: PageView(
              children: [
                EditProductPage(
                  productEntity: productEntity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
