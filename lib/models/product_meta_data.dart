import 'package:equatable/equatable.dart';

class ProductMetaData extends Equatable {
  final String createdAt;
  final String updatedAt;
  final String qrCode;

  const ProductMetaData({
    required this.createdAt,
    required this.qrCode,
    required this.updatedAt,
  });

  factory ProductMetaData.fromJson(Map<String, dynamic> meta) {
    return ProductMetaData(
      createdAt: meta['createdAt'] ?? "2025-04-30T09:41:02.053Z",
      updatedAt: meta['updatedAt'] ?? "2025-04-30T09:41:02.053Z",
      qrCode:
          meta['qrCode'] ??
          "https://fragrant.mobiletransaction.org/wp-content/uploads/2019/09/qr-code-for-wikipedia.png.webp",
    );
  }
  @override
  List<Object> get props => [createdAt, updatedAt, qrCode];
}
