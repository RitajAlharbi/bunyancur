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
  final String sellerName;
  final double price;
  final double rating;
  final String imageUrl;
  final ProductCategory category;
  final bool isFavorite;

  const ProductModel({
    required this.id,
    required this.title,
    required this.sellerName,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.category,
    required this.isFavorite,
  });

  ProductModel copyWith({
    String? id,
    String? title,
    String? sellerName,
    double? price,
    double? rating,
    String? imageUrl,
    ProductCategory? category,
    bool? isFavorite,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      sellerName: sellerName ?? this.sellerName,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProductModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
