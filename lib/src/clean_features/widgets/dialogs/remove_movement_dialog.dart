import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inventario_test/src/clean_features/entities/movement_entity.dart';
import 'package:inventario_test/src/clean_features/entities/product_entity.dart';
import 'package:inventario_test/src/controllers/logic/inventory_controller.dart';
import 'package:provider/provider.dart';

import '../../../../core/app/consts.dart';

class RemoveMovementDialog extends StatefulWidget {

  final MovementEntity movement;

  const RemoveMovementDialog({
    super.key,
    required this.movement
  });

  @override
  State<RemoveMovementDialog> createState() => _RemoveMovementDialogState();
}

class _RemoveMovementDialogState extends State<RemoveMovementDialog> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 20,
          children: [
            //* Titulo
            Text(
              "¿Remover Movimiento?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            //* Subtitulo
            Text(
              "¿Estás seguro que quieres remover este movimiento de tu inventario?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: AppColors.neutralGrey),
            ),
            //* Botón para eliminar el movimiento
            if (isLoading)
            Center(child: CircularProgressIndicator()),
            if (!isLoading)...[
              FilledButton(
                  onPressed: () async {

                    setState(() {isLoading = true;});

                    InventoryController invCtrl = context.read();

                    await invCtrl.deleteMovById(
                      widget.movement.id,
                      widget.movement.productId,
                      widget.movement.type,
                      widget.movement.qnty
                    );

                    setState(() {isLoading = false;});

                    Navigator.pop(context, true);

                  },
                  child: Text("Eliminar")
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text("No, Gracias")
              )
            ]
          ],
        ),
      ),
    );
  }
}
