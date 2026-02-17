import 'package:e_commerce_app/models/products/product_meta_data.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final String brand;
  final List<dynamic> tags;
  final String category;
  final String thumbnail;
  bool isFavorite;
  final String availabilityStatus;
  final ProductMetaData metaData;
  int quantity;
  bool isInCart;

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
    required this.isFavorite,
    required this.availabilityStatus,
    required this.metaData,
    required this.quantity,
    required this.isInCart,
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
      isFavorite: false,
      availabilityStatus: map['availabilityStatus'] ?? "",
      metaData: map['meta'] != null
          ? ProductMetaData.fromJson(map['meta'])
          : ProductMetaData.fromJson({}),
      quantity: 0,
      isInCart: false,
    );
  }

  ProductModel copyWith({bool? isFavorite, int? quantity, bool? isInCart}) {
    return ProductModel(
      id: id,
      title: title,
      description: description,
      price: price,
      rating: rating,
      brand: brand,
      tags: tags,
      category: category,
      thumbnail: thumbnail,
      isFavorite: isFavorite ?? this.isFavorite,
      availabilityStatus: availabilityStatus,
      metaData: metaData,
      quantity: quantity ?? this.quantity,
      isInCart: isInCart ?? this.isInCart,
    );
  }

  @override
  List<Object> get props => [
    id,
    title,
    description,
    price,
    rating,
    brand,
    category,
    tags,
    thumbnail,
    isFavorite,
    availabilityStatus,
    metaData,
    quantity,
    isInCart,
  ];
}
