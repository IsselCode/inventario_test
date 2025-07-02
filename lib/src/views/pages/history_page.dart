import 'package:flutter/material.dart';
import 'package:inventario_test/core/app/enums.dart';
import 'package:inventario_test/src/clean_features/widgets/history_tile_widget.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 20,),
        itemCount: 10,
        itemBuilder: (context, index) {
          return HistoryTileWidget(
            movementType: InventoryMovementType.stockOut,
            title: "Velocix Sport",
            date: DateTime.now(),
            quantity: 9,
          );
        },
      ),
    );
  }
}
