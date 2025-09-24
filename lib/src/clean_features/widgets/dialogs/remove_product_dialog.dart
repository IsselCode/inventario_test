import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inventario_test/src/clean_features/entities/product_entity.dart';
import 'package:inventario_test/src/controllers/logic/inventory_controller.dart';
import 'package:provider/provider.dart';

import '../../../../core/app/consts.dart';

class RemoveProductDialog extends StatefulWidget {

  final ProductEntity productEntity;

  const RemoveProductDialog({
    super.key,
    required this.productEntity
  });

  @override
  State<RemoveProductDialog> createState() => _RemoveProductDialogState();
}

class _RemoveProductDialogState extends State<RemoveProductDialog> {

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
            //* Imagen del producto
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  File(widget.productEntity.image),
                  height: 200,
                  width: 200,
                ),
              ),
            ),
            //* Titulo
            Text(
              "¿Remover Item?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            //* Subtitulo
            Text(
              "¿Estás seguro que quieres remover este producto de tu inventario?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: AppColors.neutralGrey),
            ),
            //* Botón para eliminar el producto
            if (isLoading)
            Center(child: CircularProgressIndicator()),
            if (!isLoading)...[
              FilledButton(
                  onPressed: () async {

                    setState(() {isLoading = true;});

                    InventoryController invCtrl = context.read();

                    await invCtrl.deleteProductById(widget.productEntity.id, widget.productEntity.image);

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
