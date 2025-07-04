import 'dart:typed_data';

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:inventario_test/core/services/toast_service.dart';
import 'package:inventario_test/inject_container.dart';
import 'package:inventario_test/src/clean_features/inputs/add_new_product_input_model.dart';
import 'package:inventario_test/src/clean_features/inputs/login_input_model.dart';
import 'package:inventario_test/src/clean_features/widgets/error_wrapper_widget.dart';
import 'package:inventario_test/src/clean_features/widgets/image_picker_widget.dart';
import 'package:inventario_test/src/clean_features/widgets/text_form_field_widget.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

class AddProductForm extends StatefulWidget {

  final Function(AddNewProductInputModel anpim) onValidate;

  const AddProductForm({
    super.key,
    required this.onValidate,
  });

  @override
  State<AddProductForm> createState() => AddProductFormState();
}

class AddProductFormState extends State<AddProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  Uint8List? selectedImage;

  //! Metodo publico para widget padre
  void triggerAction() {
    print("holaa");

    if (!_formKey.currentState!.validate()) {
      return;
    }

    Uint8List? image = selectedImage;
    String name = nameController.text;
    String description = descriptionController.text;
    String price = priceController.text;
    String quantity = quantityController.text;

    dartz.Either<List<String>, AddNewProductInputModel> response = AddNewProductInputModel.fromRaw(
      name: name,
      description: description,
      rawPrice: price,
      rawQuantity: quantity,
      image: image
    );

    return response.fold(
      (errors) {
        ToastService toastService = locator();
        toastService.error(errors.join("n"));
      },
      (r) {
        widget.onValidate(r);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [

          ImagePickerWidget(
            onChanged: (image) => selectedImage = image,
          ),

          const SizedBox(height: 30,),

          TextFormFieldWidget(
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'Este campo es obligatorio';
              if (value.trim().length < 3) return 'Mínimo 3 caracteres';
              if (value.trim().length > 50) return 'Máximo 50 caracteres';
              return null;
            },
            textEditingController: nameController,
            hintText: "Nombre",
            icon: Symbols.apparel,
          ),

          const SizedBox(height: 20,),
          TextFormFieldWidget(
            hintText: "Descripción",
            textEditingController: descriptionController,
            icon: Symbols.format_list_bulleted,
            validator: (value) {
              if (value == null || value.trim().isEmpty) return "Campo vacío";
              if (value.trim().length < 10) return 'Mínimo 10 caracteres';
              if (value.trim().length > 50) return 'Máximo 50 caracteres';
              return null;
            },
          ),

          const SizedBox(height: 20,),
          TextFormFieldWidget(
            hintText: "Precio",
            textEditingController: priceController,
            keyboardType: TextInputType.number,
            icon: Symbols.shoppingmode,
            validator: (value) {
              if (value == null || value.trim().isEmpty) return "Campo vacío";
              final price = double.tryParse(value);
              if (price == null) return 'Debe ser un número válido';
              if (price <= 0) return "El precio debe ser mayor a 0";
              return null;
            },
          ),

          const SizedBox(height: 20,),
          TextFormFieldWidget(
            hintText: "Cantidad en inventario",
            textEditingController: quantityController,
            keyboardType: TextInputType.number,
            icon: Symbols.box,
            validator: (value) {
              if (value == null || value.trim().isEmpty) return "Campo vacío";
              final qty = int.tryParse(value);
              if (qty == null) return 'Debe ser un número entero válido';
              if (qty < 0) return "La cantidad debe ser mayor o igual a 0";
              return null;
            },
          ),
        ],
      ),
    );
  }
}
