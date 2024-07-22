class Product {
  String id;
  String title;
  String price;
  String description;
  List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'].toString(),
      title: map['title'] ?? '',
      price: map['price'].toString(),
      description: map['description'] ?? '',
      images: List<String>.from(map['images'] ?? []),
    );
  }
}