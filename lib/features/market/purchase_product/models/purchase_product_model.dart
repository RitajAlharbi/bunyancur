class PurchaseProductModel {
  final String? productId;
  final String title;
  final String priceLabel;
  final String sellerName;
  final String imageUrl;
  final double rating;
  final int? quantity;
  final String? deliveryMethod;
  final String? deliveryLocation;
  final String? notes;
  final String? paymentMethod;

  const PurchaseProductModel({
    this.productId,
    required this.title,
    required this.priceLabel,
    required this.sellerName,
    required this.imageUrl,
    required this.rating,
    this.quantity,
    this.deliveryMethod,
    this.deliveryLocation,
    this.notes,
    this.paymentMethod,
  });
}
