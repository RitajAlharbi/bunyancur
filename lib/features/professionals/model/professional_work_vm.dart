/// Dummy model for professional works list.
class ProfessionalWorkVm {
  final String id;
  final String title;
  final String city;
  final String? imageUrl;

  const ProfessionalWorkVm({
    required this.id,
    required this.title,
    required this.city,
    this.imageUrl,
  });
}
