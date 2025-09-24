 import 'package:inventario_test/core/app/enums.dart';

class MovementEntity {

  int id;
  int productId;
  String productName;
  InventoryMovementType type;
  DateTime createdAt;
  int qnty;
  double priceAt;

  MovementEntity({
    required this.id,
    required this.productId,
    required this.productName,
    required this.type,
    required this.createdAt,
    required this.qnty,
    required this.priceAt
  });

  factory MovementEntity.fromMap(Map<String, Object?> map) {
    return MovementEntity(
      id: map["id"] as int,
      productId: map["product_id"] as int,
      productName: map["product_name"] as String,
      type: InventoryMovementType.fromName(map["inv_mov_type"] as String)!,
      createdAt: DateTime.parse(map["create_at"] as String).toLocal(),
      qnty: map["qnty"] as int,
      priceAt: map["price_at"] as double
    );
  }

 }