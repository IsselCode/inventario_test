import 'package:flutter/material.dart';
import 'package:inventario_test/core/app/enums.dart';
import 'package:inventario_test/src/clean_features/entities/movement_entity.dart';
import 'package:inventario_test/src/clean_features/widgets/dialogs/remove_movement_dialog.dart';
import 'package:inventario_test/src/clean_features/widgets/history_tile_widget.dart';
import 'package:inventario_test/src/controllers/logic/inventory_controller.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  late Future<void> _getMovements;

  @override
  void initState() {
    super.initState();
    InventoryController invCtrl = context.read();
    _getMovements = invCtrl.getMovements();
  }

  @override
  Widget build(BuildContext context) {
    InventoryController invCtrl = context.watch();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: FutureBuilder(
        future: _getMovements,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }

          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 20,),
            itemCount: invCtrl.movements.length,
            itemBuilder: (context, index) {
              MovementEntity movement = invCtrl.movements[index];
              return HistoryTileWidget(
                movementType: movement.type,
                priceAt: movement.priceAt,
                title: movement.productName,
                date: movement.createdAt,
                quantity: movement.qnty,
                onLongPress: () async {
                  showDialog(
                    context: context,
                    builder: (context) => RemoveMovementDialog(movement: movement),
                  );
                },
              );
            },
          );

        },
      ),
    );
  }
}
