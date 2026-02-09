/// مسارات صور المشاريع والأصول في المشروع
class AssetImagePaths {
  AssetImagePaths._();

  static const String _projectsBase = 'assets/images/projects';

  /// صور مشاريع (مجلد projects)
  static const String projectMajlis = '$_projectsBase/مجلس.png';
  static const String projectVilla = '$_projectsBase/فيلا.png';
  static const String projectVillaDisplay = '$_projectsBase/عرض_فيلا.png';
  static const String projectRenovation = '$_projectsBase/ترميم.png';
  static const String projectRenewal = '$_projectsBase/تجديد.png';
  static const String projectAdem = '$_projectsBase/عظم.png';

  /// للاستخدام مع قائمة المشاريع الحالية
  static const List<String> projectImages = [
    projectMajlis,
    projectVillaDisplay,
    projectRenovation,
    projectRenewal,
    projectVilla,
    projectVilla,
    projectMajlis,
  ];
}
