import 'package:flutter/foundation.dart';
import '../models/product_model.dart';

enum SortOption { newest, priceLowHigh, priceHighLow, ratingHigh }

extension SortOptionX on SortOption {
  String get labelAr {
    switch (this) {
      case SortOption.newest:
        return 'الأحدث';
      case SortOption.priceLowHigh:
        return 'السعر: الأقل للأعلى';
      case SortOption.priceHighLow:
        return 'السعر: الأعلى للأقل';
      case SortOption.ratingHigh:
        return 'التقييم: الأعلى أولاً';
    }
  }
}

class MarketController extends ChangeNotifier {
  String selectedCategory = 'الكل';
  String searchQuery = '';
  SortOption sortOption = SortOption.newest;
  double? minPrice;
  double? maxPrice;
  double minRating = 0;

  final List<ProductModel> allProducts = [
    const ProductModel(
      id: '1',
      title: 'حديد تسليح عالي الجودة',
      sellerName: 'أحمد العتيبي',
      price: 450,
      rating: 4.6,
       imageUrl: 'assets/images/ImageWithFallback3.png',
      category: ProductCategory.iron,
      isFavorite: false,
    ),
    const ProductModel(
      id: '2',
      title: 'سقالات كورية متكاملة',
      sellerName: 'محمد خالد',
      price: 300,
      rating: 4.2,
       imageUrl: 'assets/images/ImageWithFallback.png',
      category: ProductCategory.other,
      isFavorite: false,
    ),
    const ProductModel(
      id: '3',
      title: 'بلاط أرضيات فاخر',
      sellerName: 'فيصل القحطاني',
      price: 180,
      rating: 4.8,
     imageUrl: 'assets/images/ImageWithFallback2.png',
      category: ProductCategory.tile,
      isFavorite: false,
    ),
    const ProductModel(
      id: '4',
      title: 'خشب بناء ممتاز',
      sellerName: 'سعد الهادي',
      price: 280,
      rating: 3.9,
      imageUrl: 'assets/images/ImageWithFallback4.png',
      category: ProductCategory.wood,
      isFavorite: false,
    ),
  ];

  List<ProductModel> get filteredProducts {
    final query = searchQuery.trim().toLowerCase();
    final results = allProducts.where((product) {
      final matchesCategory = selectedCategory == 'الكل'
          ? true
          : product.category.labelAr == selectedCategory;
      final matchesQuery = query.isEmpty
          ? true
          : product.title.toLowerCase().contains(query) ||
              product.sellerName.toLowerCase().contains(query);
      final matchesMinPrice =
          minPrice == null ? true : product.price >= minPrice!;
      final matchesMaxPrice =
          maxPrice == null ? true : product.price <= maxPrice!;
      final matchesRating =
          minRating <= 0 ? true : product.rating >= minRating;
      return matchesCategory &&
          matchesQuery &&
          matchesMinPrice &&
          matchesMaxPrice &&
          matchesRating;
    }).toList();

    switch (sortOption) {
      case SortOption.newest:
        return results;
      case SortOption.priceLowHigh:
        results.sort((a, b) => a.price.compareTo(b.price));
        return results;
      case SortOption.priceHighLow:
        results.sort((a, b) => b.price.compareTo(a.price));
        return results;
      case SortOption.ratingHigh:
        results.sort((a, b) => b.rating.compareTo(a.rating));
        return results;
    }
  }

  void selectCategory(String category) {
    if (selectedCategory == category) return;
    selectedCategory = category;
    notifyListeners();
  }

  void setSortOption(SortOption option) {
    if (sortOption == option) return;
    sortOption = option;
    notifyListeners();
  }

  void setPriceRange(double? min, double? max) {
    minPrice = min;
    maxPrice = max;
    notifyListeners();
  }

  void setPriceRangeFromText(String minText, String maxText) {
    double? min;
    double? max;
    if (minText.trim().isNotEmpty) {
      min = double.tryParse(minText.trim());
    }
    if (maxText.trim().isNotEmpty) {
      max = double.tryParse(maxText.trim());
    }
    if (min != null && max != null && min > max) {
      final swap = min;
      min = max;
      max = swap;
    }
    setPriceRange(min, max);
  }

  void setMinRating(double rating) {
    if (minRating == rating) return;
    minRating = rating;
    notifyListeners();
  }

  void clearFilters() {
    sortOption = SortOption.newest;
    minPrice = null;
    maxPrice = null;
    minRating = 0;
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
