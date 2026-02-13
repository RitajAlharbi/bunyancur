import 'dart:collection';

class CreateProjectFormData {
  final String title;
  final String projectTypeId;
  final String projectTypeName;
  final String areaRange;
  final String description;
  final String city;
  final String district;
  final String address;
  final double? latitude;
  final double? longitude;
  final String budgetRange;
  final String expectedDuration;
  final List<String> selectedProviderIds;
  final List<String> uploadedImageUrls;
  @Deprecated('Legacy compatibility for designer/client flow')
  final int? customBudgetAmount;

  static const Object _unset = Object();

  const CreateProjectFormData({
    this.title = '',
    this.projectTypeId = '',
    this.projectTypeName = '',
    this.areaRange = '',
    this.description = '',
    this.city = '',
    this.district = '',
    this.address = '',
    this.latitude,
    this.longitude,
    this.budgetRange = '',
    this.expectedDuration = '',
    this.selectedProviderIds = const <String>[],
    this.uploadedImageUrls = const <String>[],
    this.customBudgetAmount,
  });

  CreateProjectFormData copyWith({
    String? title,
    String? projectTypeId,
    String? projectTypeName,
    String? areaRange,
    String? description,
    String? city,
    String? district,
    String? address,
    Object? latitude = _unset,
    Object? longitude = _unset,
    String? budgetRange,
    String? expectedDuration,
    List<String>? selectedProviderIds,
    List<String>? uploadedImageUrls,
    Object? customBudgetAmount = _unset,
    @Deprecated('Legacy alias') String? projectName,
    @Deprecated('Legacy alias') String? projectType,
    @Deprecated('Legacy alias') String? projectArea,
    @Deprecated('Legacy alias') String? projectDescription,
    @Deprecated('Legacy alias') String? timeline,
  }) {
    final resolvedTitle = title ?? projectName;
    final resolvedProjectTypeName = projectTypeName ?? projectType;
    final resolvedAreaRange = areaRange ?? projectArea;
    final resolvedDescription = description ?? projectDescription;
    final resolvedDuration = expectedDuration ?? timeline;

    return CreateProjectFormData(
      title: resolvedTitle ?? this.title,
      projectTypeId: projectTypeId ?? this.projectTypeId,
      projectTypeName: resolvedProjectTypeName ?? this.projectTypeName,
      areaRange: resolvedAreaRange ?? this.areaRange,
      description: resolvedDescription ?? this.description,
      city: city ?? this.city,
      district: district ?? this.district,
      address: address ?? this.address,
      latitude: latitude == _unset ? this.latitude : latitude as double?,
      longitude: longitude == _unset ? this.longitude : longitude as double?,
      budgetRange: budgetRange ?? this.budgetRange,
      expectedDuration: resolvedDuration ?? this.expectedDuration,
      selectedProviderIds: List<String>.unmodifiable(
        selectedProviderIds ?? this.selectedProviderIds,
      ),
      uploadedImageUrls: List<String>.unmodifiable(
        uploadedImageUrls ?? this.uploadedImageUrls,
      ),
      customBudgetAmount: customBudgetAmount == _unset
          ? this.customBudgetAmount
          : customBudgetAmount as int?,
    );
  }

  List<String> get selectedProviderIdsView =>
      UnmodifiableListView(selectedProviderIds);

  List<String> get uploadedImageUrlsView =>
      UnmodifiableListView(uploadedImageUrls);

  bool get isStep1Valid =>
      title.trim().isNotEmpty &&
      projectTypeId.trim().isNotEmpty &&
      areaRange.trim().isNotEmpty;

  bool get isLocationValid =>
      city.trim().isNotEmpty &&
      district.trim().isNotEmpty &&
      address.trim().isNotEmpty &&
      latitude != null &&
      longitude != null;

  bool get isBudgetValid =>
      budgetRange.trim().isNotEmpty && expectedDuration.trim().isNotEmpty;

  bool get isReadyToSubmit => isStep1Valid && isLocationValid && isBudgetValid;

  // Legacy aliases to keep older create_designer/client screens compiling.
  @Deprecated('Use title')
  String get projectName => title;
  @Deprecated('Use projectTypeName')
  String? get projectType => projectTypeName.isEmpty ? null : projectTypeName;
  @Deprecated('Use areaRange')
  String? get projectArea => areaRange.isEmpty ? null : areaRange;
  @Deprecated('Use description')
  String get projectDescription => description;
  @Deprecated('Use expectedDuration')
  String? get timeline => expectedDuration.isEmpty ? null : expectedDuration;
}
