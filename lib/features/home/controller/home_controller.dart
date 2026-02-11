import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/home_item_model.dart';
import '../model/professional_vm.dart';

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
  String? fullName;

  List<HomeItemModel> _recommendations = [];
  bool _isLoading = false;
  String? _error;
  bool _isDisposed = false;

  List<HomeItemModel> get recommendations => List.unmodifiable(_recommendations);
  bool get isLoading => _isLoading;
  String? get error => _error;

  void _safeNotify() {
    if (_isDisposed) return;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  String get firstName {
    final n = (fullName ?? '').trim();
    if (n.isEmpty) return '';
    return n.split(' ').first;
  }

  Future<void> loadProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final data = await Supabase.instance.client
        .from('profiles')
        .select('full_name')
        .eq('id', user.id)
        .maybeSingle();

    if (_isDisposed) return;
    fullName = data?['full_name'] as String?;
    _safeNotify();
  }

  Future<void> loadProfessionals() async {
    _isLoading = true;
    _error = null;
    _safeNotify();

    try {
      final response = await Supabase.instance.client
          .from('professional_profiles')
          .select('id,type,display_name,bio,city,logo_url')
          .order('display_name', ascending: true);

      if (_isDisposed) return;
      final list = (response as List<dynamic>?)
              ?.map((e) => ProfessionalVm.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      _recommendations = list.map(_professionalToHomeItem).toList();
      _error = null;
    } catch (e) {
      if (_isDisposed) return;
      _error = e.toString();
      _recommendations = [];
    } finally {
      if (!_isDisposed) {
        _isLoading = false;
        _safeNotify();
      }
    }
  }

  HomeItemModel _professionalToHomeItem(ProfessionalVm p) {
    final type = p.type == 'designer'
        ? HomeItemType.designer
        : p.type == 'contractor'
            ? HomeItemType.contractor
            : HomeItemType.contractor;
    final rating = type == HomeItemType.contractor ? 4.7 : 4.2;
    return HomeItemModel(
      id: p.id,
      name: p.displayName,
      location: p.city ?? '',
      rating: rating,
      imageUrl: p.logoUrl,
      type: type,
    );
  }

  List<HomeItemModel> get filteredRecommendations {
    if (selectedFilter == HomeFilter.product) {
      return const [];
    }
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
          return false;
        case HomeFilter.all:
          return true;
      }
    }).toList();
  }

  void selectFilter(HomeFilter filter) {
    if (selectedFilter == filter) return;
    selectedFilter = filter;
    _safeNotify();
  }
}
