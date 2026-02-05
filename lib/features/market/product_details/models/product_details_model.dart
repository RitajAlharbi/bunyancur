class ProductDetailsModel {
  final String title;
  final String categoryLabel;
  final String description;
  final String quantityLabel;
  final String city;
  final String priceLabel;
  final String imageUrl;
  final String sellerName;
  final String sellerRole;
  final String sellerAvatar;

  const ProductDetailsModel({
    required this.title,
    required this.categoryLabel,
    required this.description,
    required this.quantityLabel,
    required this.city,
    required this.priceLabel,
    required this.imageUrl,
    required this.sellerName,
    required this.sellerRole,
    required this.sellerAvatar,
  });
}
