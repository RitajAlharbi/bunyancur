/// View model for user profile from public.profiles table.
class ProfileVm {
  final String id;
  final String fullName;
  final String email;
  final String? phone;
  final String role;
  final String? commercialRegister;

  const ProfileVm({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
    required this.role,
    this.commercialRegister,
  });

  factory ProfileVm.fromJson(Map<String, dynamic> json) {
    return ProfileVm(
      id: json['id'] as String,
      fullName: json['full_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String?,
      role: json['role'] as String? ?? 'client',
      commercialRegister: json['commercial_register'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'email': email,
        'phone': phone,
        'role': role,
        'commercial_register': commercialRegister,
      };
}
