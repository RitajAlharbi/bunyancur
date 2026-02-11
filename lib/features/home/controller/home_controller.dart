import 'package:flutter/foundation.dart';
import '../model/home_item_model.dart';

enum HomeFilter { all, contractor, designer, product }

extension HomeFilterX on HomeFilter {
  String get labelAr {
    switch (this) {
      case HomeFilter.all:
        return 'الكل';
      case HomeFilter.contractor:
        return 'المقاول';
      case HomeFilter.designer:
        return 'المصمم';
      case HomeFilter.product:
        return 'المنتجات';
    }
  }
}

class HomeController extends ChangeNotifier {
  HomeFilter selectedFilter = HomeFilter.all;

  final List<HomeItemModel> _recommendations = const [
    HomeItemModel(
      name: 'شركة بصمة للمقاولات',
      location: 'الرياض',
      rating: 4.7,
      imageUrl: 'assets/images/Rectangle (2).png',
      type: HomeItemType.contractor,
    ),
    HomeItemModel(
      name: 'شركة الفا للتصميم',
      location: 'الخرج',
      rating: 4.2,
      imageUrl: 'assets/images/Rectangle (1).png',
      type: HomeItemType.designer,
    ),
  ];

  List<HomeItemModel> get recommendations => List.unmodifiable(_recommendations);

  List<HomeItemModel> get filteredRecommendations {
    if (selectedFilter == HomeFilter.all) {
      return recommendations;
    }
    return recommendations.where((item) {
      switch (selectedFilter) {
        case HomeFilter.contractor:
          return item.type == HomeItemType.contractor;
        case HomeFilter.designer:
          return item.type == HomeItemType.designer;
        case HomeFilter.product:
          return item.type == HomeItemType.product;
        case HomeFilter.all:
          return true;
      }
    }).toList();
  }

  void selectFilter(HomeFilter filter) {
    if (selectedFilter == filter) return;
    selectedFilter = filter;
    notifyListeners();
  }
}
