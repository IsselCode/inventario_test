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

 }