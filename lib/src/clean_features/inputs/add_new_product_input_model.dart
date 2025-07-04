import 'dart:typed_data';
import 'package:dartz/dartz.dart';

class AddNewProductInputModel {
  Uint8List? image;
  String name;
  String description;
  double price;
  int quantity;

  AddNewProductInputModel({
    this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
  });

  static Either<List<String>, AddNewProductInputModel> fromRaw({
    Uint8List? image,
    required String name,
    required String description,
    required String rawPrice,
    required String rawQuantity,
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

    // Validar cantidad
    final parsedQty = int.tryParse(rawQuantity);
    if (rawQuantity.trim().isEmpty) {
      errors.add('La cantidad es obligatoria.');
    } else if (parsedQty == null || parsedQty < 0) {
      errors.add('La cantidad debe ser un número entero válido mayor o igual a 0.');
    }

    // Retornar errores si los hay
    if (errors.isNotEmpty) {
      return left(errors);
    }

    // Todo válido, crear el modelo
    return right(AddNewProductInputModel(
      image: image,
      name: trimmedName,
      description: trimmedDescription,
      price: parsedPrice!,
      quantity: parsedQty!,
    ));
  }
}