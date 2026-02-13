import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/market_repository.dart';
import '../models/product_details_model.dart';

class ProductDetailsController extends ChangeNotifier {
  final MarketRepository _repository;
  ProductDetailsModel? product;
  List<String> imageUrls = [];
  List<Map<String, dynamic>> reviews = [];
  bool isLoading = false;
  String? error;

  ProductDetailsController({MarketRepository? repository})
      : _repository = repository ?? MarketRepository();

  Future<void> load(String productId) async {
    isLoading = true;
    error = null;
    product = null;
    notifyListeners();

    try {
      final details = await _repository.fetchProductDetails(productId);
      if (details != null) {
        final rawSellerName = (details['profiles']?['full_name'] as String?)?.trim();
        // ignore: avoid_print
        print(
          'Product details debug -> stock_qty: ${details['stock_qty']}, seller_id: ${details['seller_id']}, seller_full_name: $rawSellerName',
        );

        product = ProductDetailsModel.fromJson(
          details,
          fallbackProductId: productId,
          fallbackImageUrl: 'assets/images/ImageWithFallback2.png',
          fallbackSellerAvatar: 'assets/icons/avatar.png',
        );
        imageUrls = product!.imageUrls;
      } else {
        error = 'تعذر تحميل تفاصيل المنتج';
      }

      reviews = await _repository.fetchReviews(productId);
    } on PostgrestException catch (e) {
      // ignore: avoid_print
      print('PostgrestException details: ${e.details}');
      // ignore: avoid_print
      print('PostgrestException hint: ${e.hint}');
      error = '${e.code} - ${e.message}';
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
