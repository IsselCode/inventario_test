class ProductEntity {

  int id;
  String title;
  String description;
  double price;
  int stock;
  String image;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
    required this.image
  });

  factory ProductEntity.fromMap(Map<String, Object?> map) {
    return ProductEntity(
      id: map["id"] as int,
      title: map["title"] as String,
      description: map["description"] as String,
      price: map["price"] as double,
      stock: map["stock"] as int,
      image: map["image"] as String
    );
  }

}