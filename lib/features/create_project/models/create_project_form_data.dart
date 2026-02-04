class CreateProjectFormData {
  final String projectName;
  final String? projectType;
  final String? projectArea;
  final String projectDescription;
  final String address;
  final String city;
  final String district;

  const CreateProjectFormData({
    this.projectName = '',
    this.projectType,
    this.projectArea,
    this.projectDescription = '',
    this.address = '',
    this.city = '',
    this.district = '',
  });

  CreateProjectFormData copyWith({
    String? projectName,
    String? projectType,
    String? projectArea,
    String? projectDescription,
    String? address,
    String? city,
    String? district,
  }) {
    return CreateProjectFormData(
      projectName: projectName ?? this.projectName,
      projectType: projectType ?? this.projectType,
      projectArea: projectArea ?? this.projectArea,
      projectDescription: projectDescription ?? this.projectDescription,
      address: address ?? this.address,
      city: city ?? this.city,
      district: district ?? this.district,
    );
  }
}
