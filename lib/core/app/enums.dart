enum InventoryMovementType {
  stockIn,
  stockOut;

  static InventoryMovementType? fromName(String name) {
    switch (name) {
      case 'stockIn':
        return InventoryMovementType.stockIn;
      case 'stockOut':
        return InventoryMovementType.stockOut;
      default:
        return null;
    }
  }
}