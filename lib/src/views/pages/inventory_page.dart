import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_test/src/clean_features/widgets/inventory_tile_widget.dart';

import '../../../core/app/consts.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(20),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10,),
        itemCount: 5,
        itemBuilder: (context, index) {
          return InventoryTileWidget(
            asset: "assets/no_image.jpg",
            title: "Velocix Sport",
            description: "Ligeros, cómodos, perfectos para correr",
            onTap: () {
              print("hola");
            },
          );
        },
      ),
    );
  }
}
