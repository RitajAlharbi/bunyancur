class CreateProjectFormData {
  final String projectName;
  final String? projectType;
  final String? projectArea;
  final String projectDescription;
  final String address;
  final String city;
  final String district;
  final double? latitude;
  final double? longitude;
  final String? budgetRange;
  final String? timeline;
  final int? customBudgetAmount;

  const CreateProjectFormData({
    this.projectName = '',
    this.projectType,
    this.projectArea,
    this.projectDescription = '',
    this.address = '',
    this.city = '',
    this.district = '',
    this.latitude,
    this.longitude,
    this.budgetRange,
    this.timeline,
    this.customBudgetAmount,
  });

  CreateProjectFormData copyWith({
    String? projectName,
    String? projectType,
    String? projectArea,
    String? projectDescription,
    String? address,
    String? city,
    String? district,
    double? latitude,
    double? longitude,
    String? budgetRange,
    String? timeline,
    int? customBudgetAmount,
  }) {
    return CreateProjectFormData(
      projectName: projectName ?? this.projectName,
      projectType: projectType ?? this.projectType,
      projectArea: projectArea ?? this.projectArea,
      projectDescription: projectDescription ?? this.projectDescription,
      address: address ?? this.address,
      city: city ?? this.city,
      district: district ?? this.district,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      budgetRange: budgetRange ?? this.budgetRange,
      timeline: timeline ?? this.timeline,
      customBudgetAmount: customBudgetAmount ?? this.customBudgetAmount,
    );
  }
}
