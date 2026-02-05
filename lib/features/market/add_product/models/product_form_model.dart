class ProductFormModel {
  String name;
  String description;
  String? categoryId;
  String quantity;
  String price;
  String? cityId;
  List<String> images;
  String? attachment;

  ProductFormModel({
    this.name = '',
    this.description = '',
    this.categoryId,
    this.quantity = '',
    this.price = '',
    this.cityId,
    List<String>? images,
    this.attachment,
  }) : images = images ?? [];
}
