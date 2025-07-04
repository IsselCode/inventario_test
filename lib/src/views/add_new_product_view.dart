import 'package:flutter/material.dart';
import 'package:inventario_test/src/clean_features/widgets/filled_button_widget.dart';
import 'package:inventario_test/src/clean_features/widgets/forms/add_product_form.dart';
import 'package:inventario_test/src/clean_features/widgets/image_picker_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

class AddNewProductView extends StatelessWidget {
  const AddNewProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                // Imagen
                AddProductForm(
                  onValidate: (anpim) {

                  },
                ),

                const SizedBox(height: 20,),

                FilledButtonWidget(
                  onPressed: () {

                  },
                  icon: Symbols.arrow_forward,
                  text: "Crear producto"
                )
                // TextFields
              ],
            ),
          ),
        ),
      ),
    );
  }
}
