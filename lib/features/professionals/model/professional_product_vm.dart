/// Dummy model for professional products list.
class ProfessionalProductVm {
  final String id;
  final String name;
  final String companyName;
  final String price;
  final String? imageUrl;

  const ProfessionalProductVm({
    required this.id,
    required this.name,
    required this.companyName,
    required this.price,
    this.imageUrl,
  });
}
