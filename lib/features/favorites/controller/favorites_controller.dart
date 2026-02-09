import 'package:flutter/material.dart';

import '../model/favorite_item_model.dart';

class FavoritesController extends ChangeNotifier {
  FavoritesController() {
    _loadMockData();
  }

  int _segmentIndex = 0;
  final List<FavoriteItemModel> _products = [];
  final List<FavoriteItemModel> _accounts = [];

  int get segmentIndex => _segmentIndex;
  List<FavoriteItemModel> get products => List.unmodifiable(_products);
  List<FavoriteItemModel> get accounts => List.unmodifiable(_accounts);

  void setSegment(int index) {
    if (_segmentIndex == index) return;
    _segmentIndex = index;
    notifyListeners();
  }

  void removeProduct(String id) {
    _products.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void removeAccount(String id) {
    _accounts.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void _loadMockData() {
    _products.addAll([
      FavoriteItemModel.product(
        id: '1',
        title: 'سقالات كورية',
        sellerName: 'محمد خالد',
        price: 300,
        rating: 4.8,
        imageUrl: 'assets/images/Rectangle (2).png',
      ),
      FavoriteItemModel.product(
        id: '2',
        title: 'أدوات البناء',
        sellerName: 'عبدالله العمري',
        price: 850,
        rating: 4.7,
        imageUrl: 'assets/images/Rectangle (1).png',
      ),
    ]);
    _accounts.addAll([
      FavoriteItemModel.account(
        id: 'a1',
        name: 'لينا العتيبي',
        role: 'تصميم داخلي',
        rating: 4.9,
      ),
      FavoriteItemModel.account(
        id: 'a2',
        name: 'محمد صالح',
        role: 'عميل',
        rating: 4.8,
      ),
    ]);
    notifyListeners();
  }
}
