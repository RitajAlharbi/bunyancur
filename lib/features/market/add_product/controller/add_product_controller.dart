import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/market_repository.dart';
import '../models/product_form_model.dart';

class AddProductController extends ChangeNotifier {
  final MarketRepository _repository;
  final ProductFormModel form = ProductFormModel();
  final ImagePicker _imagePicker = ImagePicker();
  bool isSubmitting = false;
  List<MarketCategoryItem> categories = [];
  bool isLoadingCategories = false;
  String? categoriesError;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final List<String> cities = [
    'الرياض',
    'الخرج',
    'الدمام',
    'جدة',
  ];

  AddProductController({MarketRepository? repository})
      : _repository = repository ?? MarketRepository();

  Future<void> loadCategories() async {
    isLoadingCategories = true;
    categoriesError = null;
    notifyListeners();
    try {
      final response = await Supabase.instance.client
          .from('market_categories')
          .select('id,key,name_ar,sort_order')
          .eq('is_active', true)
          .order('sort_order', ascending: true);
      categories = (response as List<dynamic>)
          .map(
            (item) => MarketCategoryItem.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList();
      if (categories.isEmpty) {
        categoriesError = 'لا توجد فئات متاحة حالياً';
      }
    } catch (_) {
      categoriesError = 'تعذر تحميل الفئات، إعادة المحاولة';
      categories = [];
    } finally {
      isLoadingCategories = false;
      notifyListeners();
    }
  }

  void setSelectedCategory(String categoryId) {
    form.categoryId = categoryId;
    final selected = categories.where((item) => item.id == categoryId);
    form.categoryName = selected.isEmpty ? null : selected.first.nameAr;
    notifyListeners();
  }

  String? categoryIdByName(String? nameAr) {
    if (nameAr == null || nameAr.trim().isEmpty) return null;
    final selected = categories.where((item) => item.nameAr == nameAr);
    if (selected.isEmpty) return null;
    return selected.first.id;
  }

  List<String> get categoryNames {
    return categories.map((item) => item.nameAr).toList();
  }

  void setCategory(String value) {
    final id = categoryIdByName(value);
    if (id == null) return;
    setSelectedCategory(id);
  }

  void setCity(String value) {
    form.cityId = value;
    notifyListeners();
  }

  Future<String?> pickImages() async {
    if (form.images.length >= 3) {
      return 'يمكنك رفع حتى 3 صور للمنتج';
    }

    try {
      final picked = await _imagePicker.pickMultiImage();
      if (picked.isEmpty) return null;

      final remaining = 3 - form.images.length;
      form.images.addAll(
        picked.take(remaining).map((file) => file.path),
      );
      notifyListeners();
      return null;
    } catch (_) {
      return 'تعذر اختيار الصور حالياً، حاول مرة أخرى';
    }
  }

  void removeLastImage() {
    if (form.images.isEmpty) {
      return;
    }
    form.images.removeLast();
    notifyListeners();
  }

  String? validateRequiredFields() {
    syncTextFieldsToModel();
    if (form.categoryId == null && form.categoryName != null) {
      form.categoryId = categoryIdByName(form.categoryName);
    }
    if (form.name.trim().isEmpty) {
      return 'يرجى إدخال اسم المنتج';
    }
    if (form.categoryId == null || form.categoryId!.isEmpty) {
      return 'يرجى اختيار الفئة';
    }
    if (form.quantity.trim().isEmpty) {
      return 'يرجى إدخال الكمية المتوفرة';
    }
    if (form.price.trim().isEmpty) {
      return 'يرجى إدخال السعر';
    }
    if (form.cityId == null || form.cityId!.isEmpty) {
      return 'يرجى اختيار المدينة';
    }
    return null;
  }

  void syncTextFieldsToModel() {
    form.name = nameController.text;
    form.description = descriptionController.text;
    form.quantity = quantityController.text;
    form.price = priceController.text;
  }

  Future<String?> submitProduct() async {
    final validationError = validateRequiredFields();
    if (validationError != null) return validationError;
    if (categoriesError != null && categories.isEmpty) {
      return 'تعذر تحميل الفئات، إعادة المحاولة';
    }

    isSubmitting = true;
    notifyListeners();
    try {
      final productId = await _repository.createProduct(form);
      form.productId = productId;

      for (var i = 0; i < form.images.length; i++) {
        final localPath = form.images[i];
        // TODO: Replace with actual Supabase Storage upload and use public URL.
        final imageUrl = localPath;
        await _repository.addProductImage(productId, imageUrl, i + 1);
      }
      return null;
    } on PostgrestException catch (e) {
      if (e.message.contains('row-level security') ||
          e.message.contains('permission')) {
        return 'لا تملكين صلاحية إضافة المنتج حالياً';
      }
      if (e.message.contains('category_id')) {
        return 'يرجى اختيار فئة صحيحة قبل الإضافة';
      }
      if (e.message.contains('seller_id')) {
        return 'يجب تسجيل الدخول قبل إضافة المنتج';
      }
      return e.message.isEmpty ? 'تعذر إضافة المنتج حالياً، حاول مرة أخرى' : e.message;
    } catch (_) {
      return 'تعذر إضافة المنتج حالياً، حاول مرة أخرى';
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }
}

class MarketCategoryItem {
  final String id;
  final String nameAr;
  final String key;
  final int sortOrder;

  const MarketCategoryItem({
    required this.id,
    required this.nameAr,
    required this.key,
    required this.sortOrder,
  });

  factory MarketCategoryItem.fromJson(Map<String, dynamic> json) {
    return MarketCategoryItem(
      id: (json['id'] ?? '').toString(),
      key: (json['key'] ?? '').toString(),
      nameAr: (json['name_ar'] ?? '').toString(),
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
    );
  }
}
