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
  }) {
    return CreateProjectFormData(
      title: title ?? this.title,
      projectTypeId: projectTypeId ?? this.projectTypeId,
      projectTypeName: projectTypeName ?? this.projectTypeName,
      areaRange: areaRange ?? this.areaRange,
      description: description ?? this.description,
      city: city ?? this.city,
      district: district ?? this.district,
      address: address ?? this.address,
      latitude: latitude == _unset ? this.latitude : latitude as double?,
      longitude: longitude == _unset ? this.longitude : longitude as double?,
      budgetRange: budgetRange ?? this.budgetRange,
      expectedDuration: expectedDuration ?? this.expectedDuration,
      selectedProviderIds: List<String>.unmodifiable(
        selectedProviderIds ?? this.selectedProviderIds,
      ),
      uploadedImageUrls: List<String>.unmodifiable(
        uploadedImageUrls ?? this.uploadedImageUrls,
      ),
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
}
