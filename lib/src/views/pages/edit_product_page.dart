import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:inventario_test/src/clean_features/entities/product_entity.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../clean_features/widgets/filled_button_widget.dart';
import '../../clean_features/widgets/forms/edit_product_form.dart';

class EditProductPage extends StatefulWidget {

  final ProductEntity productEntity;
  final Uint8List? image;

  EditProductPage({
    super.key,
    required this.image,
    required this.productEntity
  });

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> with AutomaticKeepAliveClientMixin {
  GlobalKey<EditProductFormState> productFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            /// Contenido scrollable
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      EditProductForm(
                        image: widget.image,
                        product: widget.productEntity,
                        key: productFormKey,
                        onValidate: (epi) {

                        },
                      ),
                      SizedBox(height: 100), // espacio para evitar que el botón tape contenido
                    ],
                  ),
                ),
              ),
            ),

            /// Botón fijo hasta abajo
            Positioned(
              bottom: bottomPadding + 20,
              left: 0,
              right: 0,
              child: Center( // centra el botón horizontalmente
                child: FilledButtonWidget(
                  onPressed: () => productFormKey.currentState?.triggerAction(),
                  icon: Symbols.arrow_forward,
                  width: 250,
                  text: "Actualizar producto",
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
