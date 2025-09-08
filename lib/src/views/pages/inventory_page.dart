import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_test/core/services/navigation_service.dart';
import 'package:inventario_test/src/clean_features/entities/product_entity.dart';
import 'package:inventario_test/src/clean_features/widgets/inventory_tile_widget.dart';
import 'package:inventario_test/src/views/product_view.dart';

import '../../../core/app/consts.dart';
import '../../../inject_container.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  void onTapProduct(ProductEntity product) {
    NavigationService navigationService = locator();
    navigationService.navigateTo(ProductView(productEntity: product));
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(20),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10,),
        itemCount: 5,
        itemBuilder: (context, index) {
          ProductEntity productEntity = ProductEntity(
            id: index,
            title: "Velocix Sport",
            description: "Ligeros, cómodos, perfectos para correr",
            price: 5.99,
            stock: 5,
            image: "assets/no_image.jpg"
          );

          return InventoryTileWidget(
            asset: productEntity.image,
            title: productEntity.title,
            description: productEntity.description,
            onTap: () => onTapProduct(productEntity),
          );
        },
      ),
    );
  }
}
