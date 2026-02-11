class HomeItemModel {
  final String id;
  final String name;
  final String location;
  final double rating;
  final String? imageUrl;
  final HomeItemType type;

  const HomeItemModel({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.type,
    this.imageUrl,
  });
}

enum HomeItemType {
  contractor,
  designer,
  product,
}
