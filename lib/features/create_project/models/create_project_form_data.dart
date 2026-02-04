class CreateProjectFormData {
  final String projectName;
  final String? projectType;
  final String? projectArea;
  final String projectDescription;

  const CreateProjectFormData({
    this.projectName = '',
    this.projectType,
    this.projectArea,
    this.projectDescription = '',
  });

  CreateProjectFormData copyWith({
    String? projectName,
    String? projectType,
    String? projectArea,
    String? projectDescription,
  }) {
    return CreateProjectFormData(
      projectName: projectName ?? this.projectName,
      projectType: projectType ?? this.projectType,
      projectArea: projectArea ?? this.projectArea,
      projectDescription: projectDescription ?? this.projectDescription,
    );
  }
}
