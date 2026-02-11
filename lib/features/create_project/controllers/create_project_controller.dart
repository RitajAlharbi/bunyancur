import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/create_project_form_data.dart';

class ProjectTypeItem {
  final String id;
  final String nameAr;
  final int orderNo;
  final String category;
  final bool phasesEnabled;

  const ProjectTypeItem({
    required this.id,
    required this.nameAr,
    required this.orderNo,
    required this.category,
    required this.phasesEnabled,
  });

  factory ProjectTypeItem.fromJson(Map<String, dynamic> json) {
    return ProjectTypeItem(
      id: (json['id'] ?? '').toString(),
      nameAr: (json['name_ar'] ?? '').toString(),
      orderNo: (json['order_no'] as num?)?.toInt() ?? 0,
      category: (json['category'] ?? '').toString(),
      phasesEnabled: json['phases_enabled'] == true,
    );
  }
}

class ProviderItem {
  final String id;
  final String type;
  final String city;
  final String displayName;
  final double avgRating;
  final int reviewsCount;

  const ProviderItem({
    required this.id,
    required this.type,
    required this.city,
    required this.displayName,
    required this.avgRating,
    required this.reviewsCount,
  });

  factory ProviderItem.fromJson(Map<String, dynamic> json) {
    return ProviderItem(
      id: (json['id'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      city: (json['city'] ?? '').toString(),
      displayName: (json['display_name'] ?? '').toString(),
      avgRating: (json['avg_rating'] as num?)?.toDouble() ?? 0,
      reviewsCount: (json['reviews_count'] as num?)?.toInt() ?? 0,
    );
  }
}

class CreateProjectController extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  CreateProjectFormData _data = const CreateProjectFormData();
  bool _isLoadingTypes = false;
  bool _isLoadingProviders = false;
  bool _isSubmitting = false;
  String? _errorMessage;

  List<ProjectTypeItem> _projectTypes = const <ProjectTypeItem>[];
  List<ProviderItem> _recommendedProviders = const <ProviderItem>[];

  bool _isFetchingLocation = false;
  String? _locationError;
  LocationPermission _permissionStatus = LocationPermission.denied;
  LatLng? _currentLatLng;
  LatLng? _selectedLatLng;
  final ImagePicker _imagePicker = ImagePicker();
  final List<XFile> _projectImages = [];
  final List<PlatformFile> _projectFiles = [];

  CreateProjectFormData get data => _data;
  bool get isLoadingTypes => _isLoadingTypes;
  bool get isLoadingProviders => _isLoadingProviders;
  bool get isSubmitting => _isSubmitting;
  String? get errorMessage => _errorMessage;
  List<ProjectTypeItem> get projectTypes => List.unmodifiable(_projectTypes);
  List<String> get projectTypeNames =>
      _projectTypes.map((type) => type.nameAr).toList();
  List<ProviderItem> get recommendedProviders =>
      List.unmodifiable(_recommendedProviders);
  bool get isFetchingLocation => _isFetchingLocation;
  String? get locationError => _locationError;
  LatLng? get currentLatLng => _currentLatLng;
  LatLng? get selectedLatLng => _selectedLatLng;
  String? get selectedBudgetRange =>
      _data.budgetRange.isEmpty ? null : _data.budgetRange;
  String? get selectedTimeline =>
      _data.expectedDuration.isEmpty ? null : _data.expectedDuration;
  List<XFile> get projectImages => List.unmodifiable(_projectImages);
  List<PlatformFile> get projectFiles => List.unmodifiable(_projectFiles);
  bool get hasSelectedLocation =>
      _data.latitude != null && _data.longitude != null;
  bool get hasLocationPermission =>
      _permissionStatus == LocationPermission.always ||
      _permissionStatus == LocationPermission.whileInUse;
  bool get isStep1Valid => _data.isStep1Valid;
  bool get isStep3Valid => _data.isBudgetValid;
  bool get canSubmit => _data.isReadyToSubmit && !_isSubmitting;

  String get summaryProjectName =>
      _data.title.trim().isEmpty ? '-' : _data.title.trim();
  String get summaryProjectType =>
      _data.projectTypeName.trim().isEmpty ? '-' : _data.projectTypeName.trim();
  String get summaryProjectArea =>
      _data.areaRange.trim().isEmpty ? '-' : _data.areaRange.trim();
  String get summaryBudget =>
      _data.budgetRange.trim().isEmpty ? '-' : _data.budgetRange.trim();
  String get summaryTimeline => _data.expectedDuration.trim().isEmpty
      ? '-'
      : _data.expectedDuration.trim();

  String get summaryLocation {
    final parts = <String>[
      _data.address,
      _data.district,
      _data.city,
    ].where((value) => value.trim().isNotEmpty).toList();
    if (parts.isEmpty) return '-';
    return parts.join(' - ');
  }

  static const int _maxProjectImages = 10;

  final List<String> projectAreas = const [
    '100 أو أقل',
    '150 - 200',
    '200 - 300',
    '400 - 500',
    '1000 أو أكثر',
  ];

  final List<String> budgetRanges = const [
    'أقل من 25,000 ريال',
    '25,000 - 50,000 ريال',
    '50,000 - 75,000 ريال',
    '75,000 - 100,000 ريال',
    '100,000 - 150,000 ريال',
    '150,000 - 200,000 ريال',
    '200,000 - 300,000 ريال',
    '300,000 - 500,000 ريال',
    'أكثر من 500,000 ريال',
  ];

  final List<String> timelines = const [
    '1-2 أسبوع',
    '1-2 شهر',
    '3-4 شهور',
    '5-6 شهور',
    '6-11 شهر',
    'أكثر من سنة',
  ];

  Future<void> loadProjectTypes([String category = 'contractor']) async {
    _isLoadingTypes = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _client
          .from('project_types')
          .select('id,name_ar,order_no,category,phases_enabled')
          .eq('category', category)
          .order('order_no', ascending: true);

      final list = (response as List<dynamic>)
          .map((item) => ProjectTypeItem.fromJson(item as Map<String, dynamic>))
          .where((item) => item.id.isNotEmpty && item.nameAr.isNotEmpty)
          .toList();
      _projectTypes = list;
    } catch (e) {
      _errorMessage = 'تعذر تحميل أنواع المشاريع';
      _projectTypes = const <ProjectTypeItem>[];
    } finally {
      _isLoadingTypes = false;
      notifyListeners();
    }
  }

  Future<void> loadRecommendedProviders({
    String type = 'contractor',
    String? city,
  }) async {
    _isLoadingProviders = true;
    _errorMessage = null;
    notifyListeners();

    try {
      var query = _client
          .from('professional_profiles')
          .select('id,type,city,avg_rating,reviews_count,display_name')
          .eq('type', type);

      final cityValue = (city ?? _data.city).trim();
      if (cityValue.isNotEmpty) {
        query = query.eq('city', cityValue);
      }

      final response = await query
          .order('avg_rating', ascending: false)
          .order('reviews_count', ascending: false)
          .limit(20);

      _recommendedProviders = (response as List<dynamic>)
          .map((item) => ProviderItem.fromJson(item as Map<String, dynamic>))
          .where((item) => item.id.isNotEmpty)
          .toList();
    } catch (e) {
      _errorMessage = 'تعذر تحميل المقاولين المقترحين';
      _recommendedProviders = const <ProviderItem>[];
    } finally {
      _isLoadingProviders = false;
      notifyListeners();
    }
  }

  void setTitle(String value) {
    if (_data.title == value) return;
    _data = _data.copyWith(title: value);
    notifyListeners();
  }

  void setProjectType({required String id, required String name}) {
    if (_data.projectTypeId == id && _data.projectTypeName == name) return;
    _data = _data.copyWith(projectTypeId: id, projectTypeName: name);
    notifyListeners();
  }

  void setProjectTypeByName(String? name) {
    if (name == null || name.trim().isEmpty) {
      if (_data.projectTypeId.isEmpty && _data.projectTypeName.isEmpty) return;
      _data = _data.copyWith(projectTypeId: '', projectTypeName: '');
      notifyListeners();
      return;
    }
    final matched = _projectTypes.where((type) => type.nameAr == name).toList();
    if (matched.isEmpty) return;
    setProjectType(id: matched.first.id, name: matched.first.nameAr);
  }

  void setAreaRange(String value) {
    if (_data.areaRange == value) return;
    _data = _data.copyWith(areaRange: value);
    notifyListeners();
  }

  void setDescription(String value) {
    if (_data.description == value) return;
    _data = _data.copyWith(description: value);
    notifyListeners();
  }

  void setAddress(String value) {
    if (_data.address == value) return;
    _data = _data.copyWith(address: value);
    notifyListeners();
  }

  void setCity(String value) {
    if (_data.city == value) return;
    _data = _data.copyWith(city: value);
    notifyListeners();
  }

  void setDistrict(String value) {
    if (_data.district == value) return;
    _data = _data.copyWith(district: value);
    notifyListeners();
  }

  void setLocation({
    required double? latitude,
    required double? longitude,
  }) {
    if (_data.latitude == latitude && _data.longitude == longitude) return;
    _data = _data.copyWith(latitude: latitude, longitude: longitude);
    notifyListeners();
  }

  void setBudgetRange(String? value) {
    final budgetValue = value ?? '';
    if (_data.budgetRange == budgetValue) return;
    _data = _data.copyWith(budgetRange: budgetValue);
    notifyListeners();
  }

  void setExpectedDuration(String? value) {
    final durationValue = value ?? '';
    if (_data.expectedDuration == durationValue) return;
    _data = _data.copyWith(expectedDuration: durationValue);
    notifyListeners();
  }

  void setUploadedImageUrls(List<String> urls) {
    _data = _data.copyWith(uploadedImageUrls: urls);
    notifyListeners();
  }

  void toggleProviderSelection(String providerId) {
    final current = List<String>.from(_data.selectedProviderIds);
    if (current.contains(providerId)) {
      current.remove(providerId);
    } else {
      current.add(providerId);
    }
    _data = _data.copyWith(selectedProviderIds: current);
    notifyListeners();
  }

  Future<void> pickProjectImages() async {
    final selected = await _imagePicker.pickMultiImage();
    if (selected.isEmpty) return;
    final filtered = selected.where(_isAllowedImage).toList();
    if (filtered.isEmpty) return;
    final remaining = _maxProjectImages - _projectImages.length;
    if (remaining <= 0) return;
    final limited = filtered.take(remaining);
    for (final image in limited) {
      final exists = _projectImages.any((item) => item.path == image.path);
      if (!exists) {
        _projectImages.add(image);
      }
    }
    notifyListeners();
  }

  Future<void> pickProjectFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'dwg', 'jpg', 'jpeg'],
    );
    if (result == null || result.files.isEmpty) return;
    for (final file in result.files) {
      if (!_isAllowedFile(file)) continue;
      final exists = _projectFiles.any((item) => item.path == file.path);
      if (!exists) {
        _projectFiles.add(file);
      }
    }
    notifyListeners();
  }

  void removeProjectImageAt(int index) {
    if (index < 0 || index >= _projectImages.length) return;
    _projectImages.removeAt(index);
    notifyListeners();
  }

  void removeProjectFileAt(int index) {
    if (index < 0 || index >= _projectFiles.length) return;
    _projectFiles.removeAt(index);
    notifyListeners();
  }

  bool _isAllowedImage(XFile file) {
    final extension = _extensionFromPath(file.name);
    return const ['jpg', 'jpeg', 'png'].contains(extension);
  }

  bool _isAllowedFile(PlatformFile file) {
    final extension = (file.extension ?? '').toLowerCase();
    return const ['pdf', 'dwg', 'jpg', 'jpeg'].contains(extension);
  }

  String _extensionFromPath(String path) {
    final segments = path.split('.');
    if (segments.length < 2) return '';
    return segments.last.toLowerCase();
  }

  Future<bool> initializeLocation() async {
    if (_isFetchingLocation) return false;
    _isFetchingLocation = true;
    _locationError = null;
    notifyListeners();

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _locationError = 'يرجى تفعيل خدمات الموقع على الجهاز';
      _isFetchingLocation = false;
      notifyListeners();
      return false;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      _permissionStatus = permission;
      _locationError = 'لم يتم منح إذن الموقع';
      _isFetchingLocation = false;
      notifyListeners();
      return false;
    }

    _permissionStatus = permission;
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _currentLatLng = LatLng(position.latitude, position.longitude);
      return true;
    } catch (_) {
      _locationError = 'تعذر الحصول على الموقع الحالي';
      return false;
    } finally {
      _isFetchingLocation = false;
      notifyListeners();
    }
  }

  Future<void> updateSelectedLocation(LatLng latLng) async {
    if (_selectedLatLng?.latitude == latLng.latitude &&
        _selectedLatLng?.longitude == latLng.longitude) {
      return;
    }
    _isFetchingLocation = true;
    _locationError = null;
    _selectedLatLng = latLng;
    setLocation(latitude: latLng.latitude, longitude: latLng.longitude);
    await _reverseGeocode(latLng);
    _isFetchingLocation = false;
    notifyListeners();
  }

  Future<void> _reverseGeocode(LatLng latLng) async {
    try {
      final placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isEmpty) return;
      final place = placemarks.first;
      final addressParts = <String?>[
        place.street,
        place.subLocality,
        place.locality,
      ].whereType<String>().where((value) => value.trim().isNotEmpty).toList();

      final address = addressParts.isNotEmpty
          ? addressParts.join('، ')
          : (place.name ?? '');
      final city = place.locality ?? place.administrativeArea ?? '';
      final district = place.subLocality ?? place.subAdministrativeArea ?? '';

      _data = _data.copyWith(
        address: address.isNotEmpty ? address : _data.address,
        city: city.isNotEmpty ? city : _data.city,
        district: district.isNotEmpty ? district : _data.district,
      );
      _locationError = null;
    } catch (_) {
      _locationError = 'تعذر تحديد العنوان';
    }
  }

  Future<String?> submitProjectAndSendRequests() async {
    if (_isSubmitting) return null;
    _errorMessage = null;

    final user = _client.auth.currentUser;
    if (user == null) {
      _errorMessage = 'يجب تسجيل الدخول أولاً';
      notifyListeners();
      return null;
    }
    if (!_data.isReadyToSubmit) {
      _errorMessage = 'يرجى استكمال بيانات المشروع المطلوبة';
      notifyListeners();
      return null;
    }

    _isSubmitting = true;
    notifyListeners();

    try {
      // TODO: upload local files/images to Supabase Storage and store URLs.
      final projectResponse = await _client
          .from('projects')
          .insert({
            'client_id': user.id,
            'title': _data.title.trim(),
            'project_type_id': _data.projectTypeId.trim(),
            'area_range': _data.areaRange.trim(),
            'description': _data.description.trim().isEmpty
                ? null
                : _data.description.trim(),
            'city': _data.city.trim(),
            'district': _data.district.trim(),
            'address': _data.address.trim(),
            'latitude': _data.latitude,
            'longitude': _data.longitude,
            'budget_range': _data.budgetRange.trim(),
            'expected_duration': _data.expectedDuration.trim(),
            'status': 'published',
            'assigned_provider_id': null,
            'assigned_provider_role': null,
          })
          .select('id')
          .single();

      final projectId = (projectResponse['id'] ?? '').toString();
      if (projectId.isEmpty) {
        throw Exception('invalid_project_id');
      }

      final selectedProviders = _data.selectedProviderIds.toSet().toList();
      if (selectedProviders.isNotEmpty) {
        final nowIso = DateTime.now().toUtc().toIso8601String();
        final requestRows = selectedProviders
            .map(
              (providerId) => <String, dynamic>{
                'project_id': projectId,
                'provider_id': providerId,
                'status': 'pending',
                'sent_at': nowIso,
              },
            )
            .toList();
        await _client.from('service_requests').insert(requestRows);
      }

      return projectId;
    } catch (e) {
      _errorMessage = 'تعذر إنشاء المشروع حالياً، حاول مرة أخرى';
      return null;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  // Compatibility wrappers for existing widgets/screens.
  void updateProjectName(String value) => setTitle(value);
  void updateProjectType(String? value) => setProjectTypeByName(value);
  void updateProjectArea(String value) => setAreaRange(value);
  void updateProjectDescription(String value) => setDescription(value);
  void updateAddress(String value) => setAddress(value);
  void updateCity(String value) => setCity(value);
  void updateDistrict(String value) => setDistrict(value);
  void updateBudgetRange(String? value) => setBudgetRange(value);
  void updateTimeline(String? value) => setExpectedDuration(value);
}
