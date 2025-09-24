import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_test/core/services/navigation_service.dart';
import 'package:inventario_test/src/clean_features/entities/product_entity.dart';
import 'package:inventario_test/src/clean_features/widgets/inventory_tile_widget.dart';
import 'package:inventario_test/src/controllers/logic/inventory_controller.dart';
import 'package:inventario_test/src/views/product_view.dart';
import 'package:provider/provider.dart';

import '../../../core/app/consts.dart';
import '../../../inject_container.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {

  // =============== ESTADO Y PROPIEDADES =================

  late Future<void> _loadProducts;

  @override
  void initState() {
    super.initState();
    InventoryController invCtrl = context.read();
    _loadProducts = invCtrl.getProducts();
  }


  // =============== MÉTODOS DEL WIDGET =================
  void onTapProduct(ProductEntity product) {
    NavigationService navigationService = locator();
    navigationService.navigateTo(ProductView(productEntity: product));
  }

  @override
  Widget build(BuildContext context) {
    InventoryController invCtrl = context.watch();

    return Padding(
      padding: EdgeInsets.all(20),
      child: FutureBuilder(
        future: _loadProducts,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: Text("Cargando productos"),);
          }

          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 10,),
            itemCount: invCtrl.products.length,
            itemBuilder: (context, index) {
              // Obtenemos el producto mediante el index
              ProductEntity productEntity = invCtrl.products[index];
              return InventoryTileWidget(
                asset: productEntity.image,
                title: productEntity.title,
                description: productEntity.description,
                onTap: () => onTapProduct(productEntity),
              );
            },
          );

        },
      ),
    );
  }
}
