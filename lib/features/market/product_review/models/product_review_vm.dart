class ProductReviewVm {
  final String productId;
  final String orderId;
  final String? productName;
  final String? sellerName;
  final String? priceLabel;
  final String? orderNumber;
  final String? imagePath;
  final int? rating;
  final String? comment;
  final DateTime? createdAt;

  const ProductReviewVm({
    required this.productId,
    required this.orderId,
    this.productName,
    this.sellerName,
    this.priceLabel,
    this.orderNumber,
    this.imagePath,
    this.rating,
    this.comment,
    this.createdAt,
  });

  ProductReviewVm copyWith({
    String? productId,
    String? orderId,
    String? productName,
    String? sellerName,
    String? priceLabel,
    String? orderNumber,
    String? imagePath,
    int? rating,
    String? comment,
    DateTime? createdAt,
  }) {
    return ProductReviewVm(
      productId: productId ?? this.productId,
      orderId: orderId ?? this.orderId,
      productName: productName ?? this.productName,
      sellerName: sellerName ?? this.sellerName,
      priceLabel: priceLabel ?? this.priceLabel,
      orderNumber: orderNumber ?? this.orderNumber,
      imagePath: imagePath ?? this.imagePath,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
