import 'package:flutter/material.dart';
import 'package:inventario_test/src/clean_features/widgets/image_picker_widget.dart';

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
                ImagePickerWidget(
                  onChanged: (image) {
                    print(image);
                  },
                ),
                // TextFields
              ],
            ),
          ),
        ),
      ),
    );
  }
}
