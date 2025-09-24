
import 'dart:typed_data';

import 'package:inventario_test/core/app/enums.dart';
import 'package:inventario_test/src/clean_features/inputs/add_new_product_input_model.dart';

class CreateInvMovDto {

  final int productId;
  final String productName;
  final InventoryMovementType type;
  final int qnty;
  final double priceAt;

  CreateInvMovDto({
    required this.productId,
    required this.productName,
    required this.type,
    required this.qnty,
    required this.priceAt
  });

  Map<String, Object?> toMap() {
    return {
      "product_id": productId,
      "product_name": productName,
      "inv_mov_type": type.name,
      "qnty": qnty.abs(),
      "price_at": priceAt,
    };
  }


}