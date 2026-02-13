import 'dart:async';
import 'package:flutter/foundation.dart';
import '../data/market_repository.dart';
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
  final MarketRepository _repository;

  MarketController({MarketRepository? repository})
      : _repository = repository ?? MarketRepository();

  static const String allCategoryId = '__all__';

  List<MarketCategoryItem> categories = const [
    MarketCategoryItem(id: allCategoryId, label: 'الكل'),
  ];
  String selectedCategoryId = allCategoryId;
  String searchQuery = '';
  SortOption sortOption = SortOption.newest;
  double? minPrice;
  double? maxPrice;
  double minRating = 0;
  bool isLoading = false;
  String? error;

  List<ProductModel> products = [];

  List<ProductModel> get filteredProducts {
    final query = searchQuery.trim().toLowerCase();
    final results = products.where((product) {
      final matchesCategory = selectedCategoryId == allCategoryId
          ? true
          : product.categoryId == selectedCategoryId;
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

  Future<void> init() async {
    isLoading = true;
    error = null;
    notifyListeners();
    await Future.wait([_loadCategories(), _loadProducts()]);
    isLoading = false;
    notifyListeners();
  }

  Future<void> _loadCategories() async {
    try {
      final rows = await _repository.fetchCategories();
      final fetched = rows.map((row) {
        final id = row['id']?.toString() ?? '';
        final label = (row['name_ar'] ?? row['name'] ?? row['title'] ?? '').toString();
        return MarketCategoryItem(id: id, label: label);
      }).where((item) => item.id.isNotEmpty && item.label.isNotEmpty).toList();
      categories = [
        const MarketCategoryItem(id: allCategoryId, label: 'الكل'),
        ...fetched,
      ];
    } catch (_) {
      categories = const [MarketCategoryItem(id: allCategoryId, label: 'الكل')];
    }
  }

  Future<void> _loadProducts() async {
    try {
      error = null;
      final rows = await _repository.fetchProducts(
        categoryId: selectedCategoryId == allCategoryId ? null : selectedCategoryId,
        search: searchQuery,
      );
      products = await Future.wait(rows.map(_mapProduct));
    } catch (e) {
      error = e.toString();
      products = [];
    }
  }

  Future<ProductModel> _mapProduct(Map<String, dynamic> row) async {
    final productId = row['id']?.toString() ?? '';
    final images = (row['market_product_images'] as List<dynamic>? ?? const [])
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList()
      ..sort((a, b) =>
          (a['sort_order'] as num? ?? 0).compareTo(b['sort_order'] as num? ?? 0));
    final imageUrl = images.isNotEmpty
        ? (images.first['image_url']?.toString() ?? '')
        : '';

    bool favorite = false;
    if (productId.isNotEmpty) {
      favorite = await _repository.isFavorite(productId);
    }

    final categoryId = row['category_id']?.toString();
    final sellerName = (row['seller_full_name'] as String?)?.trim();
    return ProductModel(
      id: productId,
      title: (row['title'] ?? '').toString(),
      description: (row['description'] ?? '').toString(),
      stockQty: (row['stock_qty'] as num?)?.toInt() ?? 0,
      sellerName: (sellerName == null || sellerName.isEmpty)
          ? 'غير متوفر'
          : sellerName,
      price: (row['price'] as num?)?.toDouble() ?? 0,
      rating: (row['rating_avg'] as num?)?.toDouble() ?? 0,
      imageUrl: imageUrl.isNotEmpty ? imageUrl : 'assets/images/ImageWithFallback.png',
      category: _mapCategoryFromName((row['category_name'] ?? '').toString()),
      categoryId: categoryId,
      city: (row['city'] ?? '').toString(),
      currency: (row['currency'] ?? 'SAR').toString(),
      status: (row['status'] ?? '').toString(),
      sellerId: (row['seller_id'] ?? '').toString(),
      isFavorite: favorite,
    );
  }

  ProductCategory _mapCategoryFromName(String value) {
    if (value.contains('حديد')) return ProductCategory.iron;
    if (value.contains('خشب')) return ProductCategory.wood;
    if (value.contains('بلاط') || value.contains('سيراميك')) return ProductCategory.tile;
    return ProductCategory.other;
  }

  Future<void> setCategory(String id) async {
    if (selectedCategoryId == id) return;
    selectedCategoryId = id;
    isLoading = true;
    notifyListeners();
    await _loadProducts();
    isLoading = false;
    notifyListeners();
  }

  Future<void> setSearch(String text) async {
    searchQuery = text;
    isLoading = true;
    notifyListeners();
    await _loadProducts();
    isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    isLoading = true;
    notifyListeners();
    await _loadProducts();
    isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(String productId) async {
    final index = products.indexWhere((product) => product.id == productId);
    if (index == -1) return;
    final current = products[index];
    final makeFavorite = !current.isFavorite;
    products[index] = current.copyWith(isFavorite: makeFavorite);
    notifyListeners();
    try {
      await _repository.toggleFavorite(productId, makeFavorite);
    } catch (_) {
      products[index] = current;
      notifyListeners();
    }
  }

  String get selectedCategory {
    for (final item in categories) {
      if (item.id == selectedCategoryId) return item.label;
    }
    return 'الكل';
  }

  void selectCategory(String category) {
    for (final item in categories) {
      if (item.label == category) {
        unawaited(setCategory(item.id));
        return;
      }
    }
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
    unawaited(setSearch(value));
  }
}

class MarketCategoryItem {
  final String id;
  final String label;

  const MarketCategoryItem({
    required this.id,
    required this.label,
  });
}
