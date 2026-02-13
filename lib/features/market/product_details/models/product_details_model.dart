class ProductDetailsModel {
  final String? productId;
  final String title;
  final String? categoryNameAr;
  final String description;
  final int? stockQtyNullable;
  final String city;
  final double price;
  final String imageUrl;
  final String? sellerNameNullable;
  final String sellerRole;
  final String sellerAvatar;
  final List<String> imageUrls;

  const ProductDetailsModel({
    this.productId,
    required this.title,
    String? categoryLabel,
    required this.description,
    this.stockQtyNullable,
    required this.city,
    required this.price,
    required this.imageUrl,
    this.sellerNameNullable,
    required this.sellerRole,
    required this.sellerAvatar,
    this.imageUrls = const [],
  }) : categoryNameAr = categoryLabel;

  String get quantityLabel =>
      stockQtyNullable == null ? 'غير متوفر' : '${stockQtyNullable!} قطعة';
  String get categoryLabel {
    final trimmed = categoryNameAr?.trim();
    if (trimmed == null || trimmed.isEmpty) return 'غير متوفر';
    return trimmed;
  }
  String get priceLabel => '${price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2)} ريال';
  String get sellerDisplayName {
    final trimmed = sellerNameNullable?.trim();
    if (trimmed == null || trimmed.isEmpty) return 'غير متوفر';
    return trimmed;
  }

  factory ProductDetailsModel.fromJson(
    Map<String, dynamic> json, {
    String? fallbackProductId,
    String fallbackImageUrl = '',
    String fallbackSellerRole = 'بائع',
    String fallbackSellerAvatar = 'assets/icons/avatar.png',
  }) {
    final rawImages = (json['market_product_images'] as List<dynamic>? ?? const []);
    final mappedImages = rawImages
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList()
      ..sort((a, b) =>
          (a['sort_order'] as num? ?? 0).compareTo(b['sort_order'] as num? ?? 0));
    final imageUrls = mappedImages
        .map((image) => (image['image_url'] ?? '').toString())
        .where((url) => url.isNotEmpty)
        .toList();

    return ProductDetailsModel(
      productId: (json['id'] ?? fallbackProductId)?.toString(),
      title: (json['title'] ?? '').toString(),
      categoryLabel: _extractCategoryNameAr(json['market_categories']),
      description: (json['description'] ?? '').toString(),
      stockQtyNullable: (json['stock_qty'] as num?)?.toInt(),
      city: (json['city'] ?? '').toString(),
      price: (json['price'] as num?)?.toDouble() ?? 0,
      imageUrl: imageUrls.isNotEmpty ? imageUrls.first : fallbackImageUrl,
      sellerNameNullable:
          (json['seller_full_name'] as String?)?.trim() ??
              (json['profiles']?['full_name'] as String?)?.trim(),
      sellerRole: fallbackSellerRole,
      sellerAvatar: fallbackSellerAvatar,
      imageUrls: imageUrls,
    );
  }

  static String? _extractCategoryNameAr(dynamic categoryRaw) {
    if (categoryRaw is Map<String, dynamic>) {
      return (categoryRaw['name_ar'] as String?)?.trim();
    }
    if (categoryRaw is Map) {
      return (categoryRaw['name_ar'] as String?)?.trim();
    }
    return null;
  }
}
