/// View model for professional_profiles from Supabase.
class ProfessionalVm {
  final String id;
  final String type;
  final String displayName;
  final String? bio;
  final String? city;
  final String? logoUrl;

  const ProfessionalVm({
    required this.id,
    required this.type,
    required this.displayName,
    this.bio,
    this.city,
    this.logoUrl,
  });

  factory ProfessionalVm.fromJson(Map<String, dynamic> json) {
    return ProfessionalVm(
      id: json['id'] as String? ?? '',
      type: json['type'] as String? ?? 'contractor',
      displayName: json['display_name'] as String? ?? '',
      bio: json['bio'] as String?,
      city: json['city'] as String?,
      logoUrl: json['logo_url'] as String?,
    );
  }
}
