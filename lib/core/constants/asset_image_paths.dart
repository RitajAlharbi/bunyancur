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

  /// صور معرض الصور (خانة معرض الصور في تفاصيل المشروع)
  static const String gallery1 = '$_projectsBase/معرض 1.jpg';
  static const String gallery2 = '$_projectsBase/معرض2.jpg';
  static const String gallery3 = '$_projectsBase/معرض3.jpg';
  static const String gallery4 = '$_projectsBase/معرض4.jpg';

  static const List<String> galleryImages = [
    gallery1,
    gallery2,
    gallery3,
    gallery4,
  ];
}
