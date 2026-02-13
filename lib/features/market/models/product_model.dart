enum ProductCategory { iron, wood, tile, other }

extension ProductCategoryX on ProductCategory {
  String get labelAr {
    switch (this) {
      case ProductCategory.iron:
        return 'حديد';
      case ProductCategory.wood:
        return 'خشب';
      case ProductCategory.tile:
        return 'بلاط';
      case ProductCategory.other:
        return 'أخرى';
    }
  }
}

class ProductModel {
  final String id;
  final String title;
  final String description;
  final int stockQty;
  final String sellerName;
  final double price;
  final double rating;
  final String imageUrl;
  final ProductCategory category;
  final String? categoryId;
  final String city;
  final String currency;
  final String status;
  final String sellerId;
  final bool isFavorite;

  const ProductModel({
    required this.id,
    required this.title,
    this.description = '',
    this.stockQty = 0,
    required this.sellerName,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.category,
    this.categoryId,
    this.city = '',
    this.currency = 'SAR',
    this.status = '',
    this.sellerId = '',
    required this.isFavorite,
  });

  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    int? stockQty,
    String? sellerName,
    double? price,
    double? rating,
    String? imageUrl,
    ProductCategory? category,
    String? categoryId,
    String? city,
    String? currency,
    String? status,
    String? sellerId,
    bool? isFavorite,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      stockQty: stockQty ?? this.stockQty,
      sellerName: sellerName ?? this.sellerName,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      city: city ?? this.city,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      sellerId: sellerId ?? this.sellerId,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory ProductModel.fromJson(
    Map<String, dynamic> json, {
    bool isFavorite = false,
    ProductCategory defaultCategory = ProductCategory.other,
    String fallbackImageUrl = '',
  }) {
    final rawImages = (json['market_product_images'] as List<dynamic>? ?? const []);
    String firstImage = fallbackImageUrl;
    if (rawImages.isNotEmpty) {
      final mapped = rawImages
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList()
        ..sort((a, b) => (a['sort_order'] as num? ?? 0)
            .compareTo(b['sort_order'] as num? ?? 0));
      firstImage = (mapped.first['image_url'] ?? fallbackImageUrl).toString();
    }

    return ProductModel(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      stockQty: (json['stock_qty'] as num?)?.toInt() ?? 0,
      sellerName: (json['profiles']?['full_name'] ?? 'بائع').toString(),
      price: (json['price'] as num?)?.toDouble() ?? 0,
      rating: (json['rating_avg'] as num?)?.toDouble() ?? 0,
      imageUrl: firstImage,
      category: defaultCategory,
      categoryId: json['category_id']?.toString(),
      city: (json['city'] ?? '').toString(),
      currency: (json['currency'] ?? 'SAR').toString(),
      status: (json['status'] ?? '').toString(),
      sellerId: (json['seller_id'] ?? '').toString(),
      isFavorite: isFavorite,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProductModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
