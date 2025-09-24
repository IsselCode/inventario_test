import 'dart:typed_data';
import 'package:dartz/dartz.dart';

class EditProductInput {
  Uint8List image;
  String name;
  String description;
  double price;
  String lastImage;

  EditProductInput({
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.lastImage
  });

  static Either<List<String>, EditProductInput> fromRaw({
    required Uint8List image,
    required String lastImage,
    required String name,
    required String description,
    required String rawPrice,
  }) {
    final errors = <String>[];

    final trimmedName = name.trim();
    final trimmedDescription = description.trim();

    // Validar nombre
    if (trimmedName.isEmpty) {
      errors.add('El nombre es obligatorio.');
    } else if (trimmedName.length < 3) {
      errors.add('El nombre debe tener al menos 3 caracteres.');
    }

    // Validar descripción
    if (trimmedDescription.isEmpty) {
      errors.add('La descripción es obligatoria.');
    } else if (trimmedDescription.length < 10) {
      errors.add('La descripción debe tener al menos 10 caracteres.');
    }

    // Validar precio
    final parsedPrice = double.tryParse(rawPrice);
    if (rawPrice.trim().isEmpty) {
      errors.add('El precio es obligatorio.');
    } else if (parsedPrice == null || parsedPrice <= 0) {
      errors.add('El precio debe ser un número válido mayor a 0.');
    }

    // Retornar errores si los hay
    if (errors.isNotEmpty) {
      return left(errors);
    }

    // Todo válido, crear el modelo
    return right(EditProductInput(
      image: image,
      lastImage: lastImage,
      name: trimmedName,
      description: trimmedDescription,
      price: parsedPrice!,
    ));
  }
}