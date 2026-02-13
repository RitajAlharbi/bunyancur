import 'package:supabase_flutter/supabase_flutter.dart';
import '../add_product/models/product_form_model.dart';
import '../purchase_product/models/purchase_product_model.dart';
import '../product_review/models/product_review_vm.dart';

class MarketRepository {
  static const String _productsListSelect =
      'id,title,price,currency,city,status,seller_id,market_product_images(image_url,sort_order)';
  static const String _productDetailsSelect =
      'id,title,description,price,currency,city,stock_qty,seller_id,market_categories!market_products_category_id_fkey(name_ar,key),market_product_images(image_url,sort_order)';
  static const String _reviewsSelect = 'rating,comment,created_at,reviewer_id';

  SupabaseClient get _client => Supabase.instance.client;

  User? get _user => _client.auth.currentUser;

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final response = await _client
        .from('market_categories')
        .select()
        .order('sort_order', ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> fetchProducts({
    String? categoryId,
    String? search,
  }) async {
    var query = _client.from('market_products').select(_productsListSelect).eq(
          'status',
          'active',
        );

    if (categoryId != null && categoryId.isNotEmpty) {
      query = query.eq('category_id', categoryId);
    }
    final trimmedSearch = search?.trim() ?? '';
    if (trimmedSearch.isNotEmpty) {
      query = query.ilike('title', '%$trimmedSearch%');
    }

    final response = await query.order('created_at', ascending: false);
    final rows = List<Map<String, dynamic>>.from(response);
    return Future.wait(rows.map((row) async {
      final sellerId = row['seller_id']?.toString();
      if (sellerId != null && sellerId.isNotEmpty) {
        final seller = await _client
            .from('profiles_public')
            .select('full_name')
            .eq('id', sellerId)
            .maybeSingle();
        row['seller_full_name'] = seller?['full_name'];
      } else {
        row['seller_full_name'] = null;
      }
      return row;
    }));
  }

  Future<Map<String, dynamic>?> fetchProductDetails(String productId) async {
    final response = await _client
        .from('market_products')
        .select(_productDetailsSelect)
        .eq('id', productId)
        .maybeSingle();
    if (response == null) return null;
    final details = Map<String, dynamic>.from(response);
    final sellerId = details['seller_id']?.toString();
    if (sellerId != null && sellerId.isNotEmpty) {
      final seller = await _client
          .from('profiles_public')
          .select('full_name')
          .eq('id', sellerId)
          .maybeSingle();
      details['seller_full_name'] = seller?['full_name'];
    } else {
      details['seller_full_name'] = null;
    }
    return details;
  }

  Future<List<Map<String, dynamic>>> fetchReviews(String productId) async {
    final response = await _client
        .from('market_reviews')
        .select(_reviewsSelect)
        .eq('product_id', productId)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<bool> isFavorite(String productId) async {
    final user = _user;
    if (user == null) return false;

    final favorite = await _client
        .from('market_favorites')
        .select('user_id')
        .eq('user_id', user.id)
        .eq('product_id', productId)
        .maybeSingle();
    return favorite != null;
  }

  Future<void> toggleFavorite(String productId, bool makeFavorite) async {
    final user = _user;
    if (user == null) return;

    if (makeFavorite) {
      await _client.from('market_favorites').upsert({
        'user_id': user.id,
        'product_id': productId,
      });
      return;
    }

    await _client
        .from('market_favorites')
        .delete()
        .eq('user_id', user.id)
        .eq('product_id', productId);
  }

  Future<String> createProduct(ProductFormModel inputs) async {
    final sellerId = _user?.id;
    if (sellerId == null) {
      throw const AuthException('Not authenticated');
    }
    final priceValue = double.tryParse(inputs.price.trim()) ?? 0;
    final stockQtyValue = int.tryParse(inputs.quantity.trim()) ?? 0;

    final inserted = await _client
        .from('market_products')
        .insert({
          'seller_id': sellerId,
          'title': inputs.name.trim(),
          'description': inputs.description.trim(),
          'category_id': inputs.categoryId,
          'stock_qty': stockQtyValue,
          'price': priceValue,
          'currency': 'SAR',
          'city': (inputs.cityId ?? '').trim(),
          'status': 'active',
        })
        .select('id')
        .single();

    return inserted['id'].toString();
  }

  Future<void> addProductImage(
    String productId,
    String imageUrl,
    int sortOrder,
  ) async {
    await _client.from('market_product_images').insert({
      'product_id': productId,
      'image_url': imageUrl,
      'sort_order': sortOrder,
    });
  }

  Future<String> createOrder(PurchaseProductModel inputs) async {
    final buyerId = _user?.id;
    if (buyerId == null) {
      throw const AuthException('Not authenticated');
    }
    final productId = inputs.productId!;

    try {
      final productRow = await _client
          .from('market_products')
          .select('seller_id,price')
          .eq('id', inputs.productId!)
          .single();

      final qty = inputs.quantity ?? 1;
      final unitPrice = (productRow['price'] as num).toDouble();
      final subtotal = unitPrice * qty;
      const deliveryFee = 0.0;
      final total = subtotal + deliveryFee;

      final deliveryLocation = inputs.deliveryLocation?.trim() ?? '';
      final notes = inputs.notes?.trim() ?? '';
      final note = (deliveryLocation.isEmpty && notes.isEmpty)
          ? null
          : 'الموقع: $deliveryLocation | ملاحظات: $notes'.trim();

      final inserted = await _client
          .from('market_orders')
          .insert({
            'buyer_id': buyerId,
            'seller_id': productRow['seller_id'],
            'product_id': productId,
            'qty': qty,
            'unit_price': unitPrice,
            'subtotal': subtotal,
            'delivery_fee': deliveryFee,
            'total': total,
            'delivery_method': inputs.deliveryMethod,
            'payment_method': inputs.paymentMethod,
            'note': note,
            'status': 'pending',
          })
          .select('id')
          .single();

      return inserted['id'].toString();
    } on PostgrestException catch (e) {
      // ignore: avoid_print
      print('PostgrestException code: ${e.code}');
      // ignore: avoid_print
      print('PostgrestException message: ${e.message}');
      // ignore: avoid_print
      print('PostgrestException details: ${e.details}');
      // ignore: avoid_print
      print('PostgrestException hint: ${e.hint}');
      rethrow;
    }
  }

  Future<void> markOrderCompleted(String orderId) async {
    final user = _user;
    if (user == null) {
      throw const AuthException('Not authenticated');
    }
    final trimmedOrderId = orderId.trim();
    if (trimmedOrderId.isEmpty) {
      throw ArgumentError('Missing order_id');
    }

    try {
      await _client
          .from('market_orders')
          .update({'status': 'completed'})
          .eq('id', trimmedOrderId)
          .eq('buyer_id', user.id);
    } on PostgrestException catch (e) {
      // ignore: avoid_print
      print('PostgrestException code: ${e.code}');
      // ignore: avoid_print
      print('PostgrestException message: ${e.message}');
      // ignore: avoid_print
      print('PostgrestException details: ${e.details}');
      // ignore: avoid_print
      print('PostgrestException hint: ${e.hint}');
      rethrow;
    }
  }

  Future<void> submitReview(ProductReviewVm inputs) async {
    final user = _user;
    if (user == null) {
      throw const AuthException('Not authenticated');
    }
    if (inputs.productId.trim().isEmpty || inputs.orderId.trim().isEmpty) {
      throw ArgumentError('Missing product_id/order_id');
    }

    try {
      await _client.from('market_reviews').insert({
        'product_id': inputs.productId,
        'order_id': inputs.orderId,
        'reviewer_id': user.id,
        'rating': inputs.rating,
        'comment': inputs.comment,
        'created_at': inputs.createdAt?.toIso8601String(),
      });
    } on PostgrestException catch (e) {
      // ignore: avoid_print
      print('PostgrestException code: ${e.code}');
      // ignore: avoid_print
      print('PostgrestException message: ${e.message}');
      // ignore: avoid_print
      print('PostgrestException details: ${e.details}');
      // ignore: avoid_print
      print('PostgrestException hint: ${e.hint}');
      rethrow;
    }
  }

}
