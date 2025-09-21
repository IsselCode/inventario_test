import 'dart:typed_data';

import 'package:inventario_test/src/clean_features/inputs/add_new_product_input_model.dart';

class CreateProductDto {

  final String title;
  final String description;
  final double price;
  final int stock;
  final Uint8List? imageBytes;
  late String? _imageDirectory;
  String? get imageDirectory => _imageDirectory;
  set imageDirectory(String? value) {
    _imageDirectory = value;
  }

  CreateProductDto({
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
    required this.imageBytes,
  });

  factory CreateProductDto.fromInput(AddNewProductInputModel anpim) {
    return CreateProductDto(
      title: anpim.name,
      description: anpim.description,
      price: anpim.price,
      stock: anpim.quantity,
      imageBytes: anpim.image
    );
  }

  Map<String, Object?> toMap() {
    return {
      "title": title,
      "description": description,
      "price": price,
      "stock": stock,
      "image": _imageDirectory,
    };
  }


}