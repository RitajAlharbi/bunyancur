import 'package:flutter/material.dart';
import '../../../../core/routing/routes.dart';
import '../../data/market_repository.dart';
import '../models/order_success_vm.dart';
import '../../product_review/models/product_review_vm.dart';

class OrderSuccessController extends ChangeNotifier {
  final OrderSuccessVm order;
  final MarketRepository _repository;

  OrderSuccessController({
    OrderSuccessVm? initialOrder,
    MarketRepository? repository,
  })  : _repository = repository ?? MarketRepository(),
        order = initialOrder ??
            const OrderSuccessVm(
              orderId: '2025-1896',
              productId: '1',
              orderNumber: 'BN-2025-1896',
              productName: 'سقالات كورية متكاملة',
              sellerName: 'محمد خالد',
              imagePath: 'assets/icons/Icon.jpg',
              quantity: '1',
              price: '300 ريال',
              deliveryMethod: 'شحن',
              location: 'الخرج - حي النخيل',
              eta: 'خلال 3-5 أيام عمل',
              total: '300 ريال',
            );

  void onBackToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.homeScreen,
      (route) => false,
    );
  }

  void onMessageSeller(BuildContext context) {
    Navigator.pushNamed(context, Routes.messagesScreen);
  }

  Future<ProductReviewVm> confirmDeliveryForReview() async {
    final productId = order.productId?.trim() ?? '';
    final orderId = order.orderId?.trim() ?? '';
    if (productId.isEmpty || orderId.isEmpty) {
      throw ArgumentError('معرّف الطلب/المنتج غير متوفر');
    }
    await _repository.markOrderCompleted(orderId);

    return ProductReviewVm(
      productId: productId,
      orderId: orderId,
      productName: order.productName,
      sellerName: order.sellerName,
      priceLabel: order.price,
      orderNumber: order.orderNumber,
      imagePath: order.imagePath,
    );
  }
}
