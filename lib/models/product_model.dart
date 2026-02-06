class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final String brand;
  final List<dynamic> tags;
  final String category;
  final String thumbnail;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.brand,
    required this.tags,
    required this.category,
    required this.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? 1,
      title: map['title'] ?? "un known",
      description: map['description'] ?? '',
      price: map['price'] ?? 1.1,
      rating: map['rating'] ?? 2.2,
      brand: map['brand'] ?? "",
      tags: map['tags'] != null ? List<dynamic>.from(map['tags']) : [],
      category: map['category'] ?? '',
      thumbnail: map['thumbnail'] ?? "",
    );
  }
}
