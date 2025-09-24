import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {

  final Function(Uint8List? image) onChanged;
  final Uint8List? initialImage;

  const ImagePickerWidget({
    super.key,
    required this.onChanged,
    this.initialImage
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {

  Uint8List? showImage;

  @override
  void initState() {
    super.initState();
    showImage = widget.initialImage;
  }

  Future<void> selectImage() async {
    // Creamos instancia de ImagePicker
    ImagePicker imagePicker = ImagePicker();

    // Configuramos para obtener imagen desde la galería
    XFile? pickImage = await imagePicker.pickImage(source: ImageSource.gallery);

    // Comprobamos que se haya seleccionado una imagen
    if (pickImage == null) {
      return;
    }

    // Creamos instancia del archivo
    File file = File(pickImage.path);

    // Convertimos el archivo a bytes
    Uint8List image = await file.readAsBytes();

    // Asignamos la imagen
    showImage = image;

    // Repintamos el widget
    setState(() {});

    // Enviamos la imagen al widget padre
    widget.onChanged(image);
  }

  void clearImage() {
    showImage = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Contenedor de imagen
        InkWell(
          onTap: selectImage,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            margin: EdgeInsets.all(3),
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Expanded(child: showImage != null
                          ? Image.memory(showImage!)
                          : Image.asset("assets/no_image.jpg")
                        ),
                        if (showImage == null)...[
                          const SizedBox(height: 10,),
                          Text("Selecciona una imagen")
                        ]
                      ],
                    ),
                  )
              ),
            ),
          ),
        ),
        // Botón para eliminar imagen
        if (widget.initialImage == null)
        Positioned(
          right: 0,
          child: CloseButton(
            color: Colors.red,
            onPressed: clearImage,
          ),
        )
      ],
    );
  }
}
