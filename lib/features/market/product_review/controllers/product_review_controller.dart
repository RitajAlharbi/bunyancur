import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/market_repository.dart';
import '../models/product_review_vm.dart';

class ProductReviewController extends ChangeNotifier {
  static const int maxImages = 4;
  static const int maxCommentChars = 500;

  final MarketRepository _repository;
  final ProductReviewVm product;
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController commentController = TextEditingController();

  int rating = 0;
  bool isSubmitting = false;
  String? errorMessage;
  final List<XFile> _images = [];

  ProductReviewController({
    required ProductReviewVm initialProduct,
    MarketRepository? repository,
  })  : _repository = repository ?? MarketRepository(),
        product = initialProduct {
    commentController.addListener(notifyListeners);
  }

  List<XFile> get images => List.unmodifiable(_images);

  void setRating(int value) {
    rating = value.clamp(0, 5);
    notifyListeners();
  }

  Future<void> pickImages() async {
    if (_images.length >= maxImages) return;
    final picked = await _imagePicker.pickMultiImage();
    if (picked.isEmpty) return;

    final remaining = maxImages - _images.length;
    _images.addAll(picked.take(remaining));
    notifyListeners();
  }

  void removeImage(int index) {
    if (index < 0 || index >= _images.length) return;
    _images.removeAt(index);
    notifyListeners();
  }

  String get counterText => '${commentController.text.length}/500';

  String? validate() {
    if (product.productId.trim().isEmpty || product.orderId.trim().isEmpty) {
      return 'معرّف الطلب/المنتج غير متوفر';
    }
    if (rating <= 0) return 'يرجى اختيار تقييم للمنتج';
    if (commentController.text.length > maxCommentChars) {
      return 'عدد الأحرف يجب أن لا يتجاوز 500';
    }
    return null;
  }

  Future<bool> submitReview() async {
    final error = validate();
    if (error != null) {
      errorMessage = error;
      notifyListeners();
      return false;
    }

    errorMessage = null;
    isSubmitting = true;
    notifyListeners();
    try {
      final payload = product.copyWith(
        rating: rating,
        comment: commentController.text.trim().isEmpty
            ? null
            : commentController.text.trim(),
        createdAt: DateTime.now(),
      );
      await _repository.submitReview(payload);
      errorMessage = null;
      return true;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    commentController.removeListener(notifyListeners);
    commentController.dispose();
    super.dispose();
  }
}
