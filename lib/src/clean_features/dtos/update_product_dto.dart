import 'dart:typed_data';

import 'package:inventario_test/src/clean_features/inputs/add_new_product_input_model.dart';
import 'package:inventario_test/src/clean_features/inputs/edit_product_input.dart';

class UpdateProductDto {

  final String title;
  final String description;
  final double price;
  final String lastImage;
  final Uint8List? imageBytes;
  late String? _imageDirectory;
  String? get imageDirectory => _imageDirectory;
  set imageDirectory(String? value) {
    _imageDirectory = value;
  }

  UpdateProductDto({
    required this.title,
    required this.description,
    required this.price,
    required this.imageBytes,
    required this.lastImage,
  });

  factory UpdateProductDto.fromInput(EditProductInput epi) {
    return UpdateProductDto(
      title: epi.name,
      description: epi.description,
      lastImage: epi.lastImage,
      price: epi.price,
      imageBytes: epi.image
    );
  }

  Map<String, Object?> toMap() {
    return {
      "title": title,
      "description": description,
      "price": price,
      "image": _imageDirectory,
    };
  }


}