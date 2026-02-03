import 'package:flutter/foundation.dart';
import '../models/product_model.dart';

class MarketController extends ChangeNotifier {
  String selectedCategory = 'الكل';
  String searchQuery = '';

  final List<ProductModel> allProducts = [
    const ProductModel(
      id: '1',
      title: 'حديد تسليح عالي الجودة',
      sellerName: 'أحمد العتيبي',
      price: 450,
      imageUrl: 'assets/images/Rectangle (2).png',
      category: ProductCategory.iron,
      isFavorite: false,
    ),
    const ProductModel(
      id: '2',
      title: 'سقالات كورية متكاملة',
      sellerName: 'محمد خالد',
      price: 300,
      imageUrl: 'assets/images/Rectangle (1).png',
      category: ProductCategory.other,
      isFavorite: false,
    ),
    const ProductModel(
      id: '3',
      title: 'بلاط أرضيات فاخر',
      sellerName: 'فيصل القحطاني',
      price: 180,
      imageUrl: 'assets/images/service1.png',
      category: ProductCategory.tile,
      isFavorite: false,
    ),
    const ProductModel(
      id: '4',
      title: 'خشب بناء ممتاز',
      sellerName: 'سعد الهادي',
      price: 280,
      imageUrl: 'assets/images/service2.png',
      category: ProductCategory.wood,
      isFavorite: false,
    ),
  ];

  List<ProductModel> get filteredProducts {
    final query = searchQuery.trim().toLowerCase();
    return allProducts.where((product) {
      final matchesCategory = selectedCategory == 'الكل'
          ? true
          : product.category.labelAr == selectedCategory;
      final matchesQuery = query.isEmpty
          ? true
          : product.title.toLowerCase().contains(query) ||
              product.sellerName.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  void selectCategory(String category) {
    if (selectedCategory == category) return;
    selectedCategory = category;
    notifyListeners();
  }

  void updateSearch(String value) {
    searchQuery = value;
    notifyListeners();
  }

  void toggleFavorite(String productId) {
    final index = allProducts.indexWhere((product) => product.id == productId);
    if (index == -1) return;
    final current = allProducts[index];
    allProducts[index] = current.copyWith(isFavorite: !current.isFavorite);
    notifyListeners();
  }
}
