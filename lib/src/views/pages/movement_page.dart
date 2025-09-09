import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:inventario_test/src/clean_features/entities/product_entity.dart';
import 'package:inventario_test/src/clean_features/widgets/stock_delta_picker.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../clean_features/widgets/filled_button_widget.dart';

class MovementPage extends StatefulWidget {

  final Uint8List? image;
  final ProductEntity productEntity;

  const MovementPage({
    super.key,
    required this.image,
    required this.productEntity,
  });

  @override
  State<MovementPage> createState() => _MovementPageState();
}

class _MovementPageState extends State<MovementPage> {
  int delta = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Column(
        spacing: 50,
        children: [
          //* Imagen
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            padding: EdgeInsets.all(20),
            child: Center(
                child: widget.image != null
                    ? Image.memory(widget.image!, width: 220, height: 220,)
                    : Image.asset("assets/no_image.jpg", width: 220, height: 220)
            ),
          ),
          //* Titulo y Stock
          Flex(
            spacing: 20,
            direction: Axis.vertical,
            children: [
              Text(widget.productEntity.title),
              Text(widget.productEntity.stock.toString(), style: textTheme.displaySmall?.copyWith(color: colorScheme.primary),)
            ],
          ),
          //* Counter
          StockDeltaPicker(
            value: delta,
            min: -widget.productEntity.stock,
            max: 9999999,
            onChanged: (value, type) {
              print(value);
              delta = value;
              print(type);
              setState(() {});
            },
      
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Center( // centra el botón horizontalmente
              child: FilledButtonWidget(
                onPressed: () {
      
                },
                icon: Symbols.arrow_forward,
                width: 250,
                text: "Actualizar producto",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
