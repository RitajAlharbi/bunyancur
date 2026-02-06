import 'package:flutter/material.dart';
import '../models/product_form_model.dart';

class AddProductController extends ChangeNotifier {
  final ProductFormModel form = ProductFormModel();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final List<String> categories = [
    'حديد',
    'خشب',
    'سيراميك',
    'مواد بناء',
  ];

  final List<String> cities = [
    'الرياض',
    'الخرج',
    'الدمام',
    'جدة',
  ];

  void setCategory(String value) {
    form.categoryId = value;
    notifyListeners();
  }

  void setCity(String value) {
    form.cityId = value;
    notifyListeners();
  }

  void addMockImage() {
    if (form.images.length >= 3) {
      return;
    }
    form.images.add('mock_image_${form.images.length + 1}');
    notifyListeners();
  }

  void removeLastImage() {
    if (form.images.isEmpty) {
      return;
    }
    form.images.removeLast();
    notifyListeners();
  }

  void toggleAttachment() {
    if (form.attachment == null) {
      form.attachment = 'شهادة ضمان.pdf';
    } else {
      form.attachment = null;
    }
    notifyListeners();
  }

  String? validateRequiredFields() {
    syncTextFieldsToModel();
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

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
