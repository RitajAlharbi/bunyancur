import 'package:flutter/material.dart';

import '../../../core/constants/asset_image_paths.dart';
import '../../../core/routing/routes.dart';
import '../../../models/project_model.dart';
import '../model/filter_model.dart';

class AvailableProjectsController extends ChangeNotifier {
  AvailableProjectsController() {
    _loadMockData();
  }

  final List<ProjectModel> _allProjects = [];
  FilterType _selectedFilter = FilterType.all;
  int _selectedBottomNavIndex = 0; // Home active on this screen

  List<ProjectModel> get allProjects => List.unmodifiable(_allProjects);
  FilterType get selectedFilter => _selectedFilter;
  int get selectedBottomNavIndex => _selectedBottomNavIndex;

  List<ProjectModel> get filteredProjects {
    if (_selectedFilter == FilterType.all) return _allProjects;
    // Placeholder: other filters would filter by area/type/budget when implemented
    return _allProjects;
  }

  void setFilter(FilterType type) {
    if (_selectedFilter == type) return;
    _selectedFilter = type;
    notifyListeners();
  }

  void onBottomNavTap(int index, BuildContext context) {
    if (_selectedBottomNavIndex == index) return;
    _selectedBottomNavIndex = index;
    notifyListeners();
    _navigateFromBottomNav(index, context);
  }

  void _navigateFromBottomNav(int index, BuildContext context) {
    final navigator = Navigator.of(context);
    switch (index) {
      case 0:
        navigator.pushReplacementNamed(Routes.contractorHomeView);
        break;
      case 1:
        // Already on Available Projects (المشاريع)
        break;
      case 2:
        navigator.pushReplacementNamed(Routes.contractorHomeView);
        break;
      case 3:
        navigator.pushReplacementNamed(Routes.contractorHomeView);
        break;
      case 4:
        navigator.pushReplacementNamed(Routes.contractorHomeView);
        break;
    }
  }

  void onViewDetails(ProjectModel project, BuildContext context) {
    Navigator.of(context).pushNamed(
      Routes.contractorProjectDetailsScreen,
      arguments: project,
    );
  }

  void _loadMockData() {
    const description = 'عندي فيلا قديمة عمرها أكثر من 15 سنة وأبغى أرممها بالكامل من الداخل والخارج. أحتاج دهان جديد، وتبديل الأرضيات، وتغيير دورات المياه والمطبخ، وتصليح الكهرباء والسباكة لأنها قديمة بعد الترميم أبغى شكل حديث ومرتب يشبه الفلل الجديدة، مع إنارة جميلة وديكورات بسيطة. ما أبي هدم كامل، فقط تحسين وتجديد شامل للفيلا.';
    _allProjects.addAll([
      ProjectModel(
        id: '1',
        title: 'تجديد واجهة محل تجاري',
        clientName: 'محمد صالح',
        imagePath: AssetImagePaths.projectRenewal,
        status: '',
        city: 'الرياض',
        date: '2025/08/15',
        projectType: 'تجديد',
        budget: 'أكثر من 500,000 ريال',
        area: '200-300',
        duration: '6 أشهر',
        description: description,
        galleryImagePaths: AssetImagePaths.projectImages,
        mapLocation: null,
      ),
      ProjectModel(
        id: '2',
        title: 'ترميم منزل قديم',
        clientName: 'محمد صالح',
        imagePath: AssetImagePaths.projectVilla,
        status: '',
        city: 'الخرج',
        date: '2025/08/15',
        projectType: 'بناء كامل',
        budget: 'أكثر من 500,000 ريال',
        area: '400-500',
        duration: 'أكثر من سنة',
        description: description,
        galleryImagePaths: AssetImagePaths.projectImages,
        mapLocation: null,
      ),
      ProjectModel(
        id: '3',
        title: 'ترميم واجهة فيلا قديمة',
        clientName: 'أحمد محمد',
        imagePath: AssetImagePaths.projectRenovation,
        status: '',
        city: 'الخرج',
        date: '2025/07/20',
        projectType: 'ترميم',
        budget: '300,000 - 500,000 ريال',
        area: '300-400',
        duration: 'سنة',
        description: description,
        galleryImagePaths: AssetImagePaths.projectImages,
        mapLocation: null,
      ),
      ProjectModel(
        id: '4',
        title: 'بناء مجلس خارجي',
        clientName: 'صالح العتيبي',
        imagePath: AssetImagePaths.projectMajlis,
        status: '',
        city: 'الرياض',
        date: '2025/09/01',
        projectType: 'بناء',
        budget: 'أكثر من 500,000 ريال',
        area: '150-200',
        duration: '8 أشهر',
        description: description,
        galleryImagePaths: AssetImagePaths.projectImages,
        mapLocation: null,
      ),
    ]);
    notifyListeners();
  }
}
