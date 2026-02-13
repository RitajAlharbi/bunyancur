class ProductFormModel {
  String? productId;
  String name;
  String description;
  String? categoryId;
  String? categoryName;
  String quantity;
  String price;
  String? cityId;
  List<String> images;

  ProductFormModel({
    this.productId,
    this.name = '',
    this.description = '',
    this.categoryId,
    this.categoryName,
    this.quantity = '',
    this.price = '',
    this.cityId,
    List<String>? images,
  }) : images = images ?? [];
}
