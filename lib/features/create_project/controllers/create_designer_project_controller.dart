import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/create_project_form_data.dart';

/// Controller for the Interior Designer (المصمم الداخلي) project creation flow.
/// Uses the same form data and logic as contractor flow but with designer-specific project types.
class CreateDesignerProjectController extends ChangeNotifier {
  CreateProjectFormData _data = const CreateProjectFormData();
  bool _isFetchingLocation = false;
  String? _locationError;
  LocationPermission _permissionStatus = LocationPermission.denied;
  LatLng? _currentLatLng;
  LatLng? _selectedLatLng;
  final ImagePicker _imagePicker = ImagePicker();
  final List<XFile> _projectImages = [];
  final List<PlatformFile> _projectFiles = [];

  CreateProjectFormData get data => _data;
  bool get isFetchingLocation => _isFetchingLocation;
  String? get locationError => _locationError;
  LatLng? get currentLatLng => _currentLatLng;
  LatLng? get selectedLatLng => _selectedLatLng;
  String? get selectedBudgetRange => _data.budgetRange;
  String? get selectedTimeline => _data.timeline;
  int? get customBudgetAmount => _data.customBudgetAmount;
  List<XFile> get projectImages => List.unmodifiable(_projectImages);
  List<PlatformFile> get projectFiles => List.unmodifiable(_projectFiles);
  bool get hasSelectedLocation =>
      _data.latitude != null && _data.longitude != null;
  bool get hasLocationPermission =>
      _permissionStatus == LocationPermission.always ||
      _permissionStatus == LocationPermission.whileInUse;
  bool get isStep1Valid =>
      _data.projectName.trim().isNotEmpty &&
      _data.projectType != null &&
      _data.projectArea != null;
  bool get isCustomBudgetSelected => _data.budgetRange == _customBudgetLabel;
  bool get hasUploadedImages => _projectImages.isNotEmpty;
  bool get hasUploadedFiles => _projectFiles.isNotEmpty;
  bool get isStep4Valid => hasUploadedImages && hasUploadedFiles;
  bool get isStep3Valid {
    if (_data.budgetRange == null || _data.timeline == null) {
      return false;
    }
    if (isCustomBudgetSelected) {
      return _data.customBudgetAmount != null;
    }
    return true;
  }

  String get formattedBudget {
    if (_data.customBudgetAmount == null) return '';
    final formatted = _formatBudgetAmount(_data.customBudgetAmount!);
    return '$formatted ريال';
  }

  String get summaryProjectName =>
      _data.projectName.trim().isEmpty ? '-' : _data.projectName.trim();
  String get summaryProjectType => _data.projectType ?? '-';
  String get summaryProjectArea => _data.projectArea ?? '-';
  String get summaryBudget {
    if (_data.budgetRange == null) return '-';
    if (isCustomBudgetSelected) {
      return formattedBudget.isEmpty ? '-' : formattedBudget;
    }
    return _data.budgetRange!;
  }

  String get summaryTimeline => _data.timeline ?? '-';

  String get summaryLocation {
    final parts = <String>[
      _data.address,
      _data.district,
      _data.city,
    ].where((value) => value.trim().isNotEmpty).toList();
    if (parts.isEmpty) return '-';
    return parts.join(' - ');
  }

  static const String _customBudgetLabel = 'تحديد مبلغ آخر';
  static const int _maxProjectImages = 10;

  /// Interior designer–only project types. Do not use for contractor flow.
  final List<String> projectTypes = const [
    'تصميم داخلي كامل',
    'تصميم صالة/مجلس',
    'تصميم غرفة واحدة',
    'تصميم مطبخ',
    'تصميم غرف النوم',
    'استشارة تصميم داخلي',
    'تصميم الحمام',
    'أخرى',
  ];

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
    _customBudgetLabel,
  ];

  final List<String> timelines = const [
    '1-2 أسبوع',
    '1-2 شهر',
    '3-4 شهور',
    '5-6 شهور',
    '6-11 شهر',
    'أكثر من سنة',
  ];

  void updateProjectName(String value) {
    if (_data.projectName == value) return;
    _data = _data.copyWith(projectName: value);
    notifyListeners();
  }

  void updateProjectType(String? value) {
    if (_data.projectType == value) return;
    _data = _data.copyWith(projectType: value);
    notifyListeners();
  }

  void updateProjectArea(String value) {
    if (_data.projectArea == value) return;
    _data = _data.copyWith(projectArea: value);
    notifyListeners();
  }

  void updateProjectDescription(String value) {
    if (_data.projectDescription == value) return;
    _data = _data.copyWith(projectDescription: value);
    notifyListeners();
  }

  void updateAddress(String value) {
    if (_data.address == value) return;
    _data = _data.copyWith(address: value);
    notifyListeners();
  }

  void updateCity(String value) {
    if (_data.city == value) return;
    _data = _data.copyWith(city: value);
    notifyListeners();
  }

  void updateDistrict(String value) {
    if (_data.district == value) return;
    _data = _data.copyWith(district: value);
    notifyListeners();
  }

  void updateBudgetRange(String? value) {
    if (_data.budgetRange == value) return;
    _data = _data.copyWith(
      budgetRange: value,
      customBudgetAmount: value == _customBudgetLabel
          ? _data.customBudgetAmount
          : null,
    );
    notifyListeners();
  }

  void updateTimeline(String? value) {
    if (_data.timeline == value) return;
    _data = _data.copyWith(timeline: value);
    notifyListeners();
  }

  void updateCustomBudgetAmount(int? value) {
    if (_data.customBudgetAmount == value) return;
    _data = _data.copyWith(customBudgetAmount: value);
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

  String _formatBudgetAmount(int amount) {
    final digits = amount.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      final positionFromEnd = digits.length - i;
      buffer.write(digits[i]);
      if (positionFromEnd > 1 && positionFromEnd % 3 == 1) {
        buffer.write(',');
      }
    }
    return buffer.toString();
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
    _data = _data.copyWith(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
    );
    notifyListeners();
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
}
