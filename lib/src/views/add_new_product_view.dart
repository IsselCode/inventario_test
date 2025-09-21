import 'package:flutter/material.dart';
import 'package:inventario_test/src/clean_features/inputs/add_new_product_input_model.dart';
import 'package:inventario_test/src/clean_features/widgets/filled_button_widget.dart';
import 'package:inventario_test/src/clean_features/widgets/forms/add_product_form.dart';
import 'package:inventario_test/src/controllers/logic/inventory_controller.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class AddNewProductView extends StatelessWidget {

  AddNewProductView({super.key});

  GlobalKey<AddProductFormState> productFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true, // deja que el teclado ajuste el contenido
      appBar: AppBar(),
      body: LayoutBuilder(
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
                        AddProductForm(
                          key: productFormKey,
                          onValidate: (anpim) => createProduct(context, anpim),
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
                    text: "Crear producto",
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }


  Future<void> createProduct(BuildContext context, AddNewProductInputModel anpim) async {
    InventoryController invCtrl = context.read();
    await invCtrl.createNewProduct(anpim);
  }

}
