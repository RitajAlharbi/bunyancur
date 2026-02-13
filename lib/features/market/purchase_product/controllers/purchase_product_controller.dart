import 'package:flutter/material.dart';
import '../../data/market_repository.dart';
import '../../order_success/models/order_success_vm.dart';
import '../models/purchase_product_model.dart';

enum PaymentMethod { cashOnDelivery, bankTransfer, bunyanWallet }

class PurchaseProductController extends ChangeNotifier {
  final MarketRepository _repository;
  final PurchaseProductModel product;
  bool isSubmitting = false;

  final TextEditingController quantityController = TextEditingController();
  final TextEditingController deliveryLocationController =
      TextEditingController();
  final TextEditingController notesController = TextEditingController();

  final List<String> deliveryMethods = [
    'استلام من البائع',
    'توصيل',
  ];

  String? selectedDeliveryMethod;
  PaymentMethod selectedPayment = PaymentMethod.cashOnDelivery;

  PurchaseProductController({
    required this.product,
    MarketRepository? repository,
  }) : _repository = repository ?? MarketRepository() {
    quantityController.addListener(_onRequiredFieldChanged);
    deliveryLocationController.addListener(_onRequiredFieldChanged);
  }

  void _onRequiredFieldChanged() {
    notifyListeners();
  }

  void selectDeliveryMethod(String value) {
    selectedDeliveryMethod = value;
    notifyListeners();
  }

  void selectPayment(PaymentMethod method) {
    selectedPayment = method;
    notifyListeners();
  }

  int get quantityValue {
    final parsed = int.tryParse(quantityController.text.trim());
    if (parsed == null || parsed <= 0) return 1;
    return parsed;
  }

  int get _unitPriceValue {
    final digitsOnly = product.priceLabel.replaceAll(RegExp(r'[^0-9]'), '');
    final parsed = int.tryParse(digitsOnly);
    if (parsed == null || parsed <= 0) return 0;
    return parsed;
  }

  String get lineItemPriceLabel {
    final unitPrice = _unitPriceValue;
    if (unitPrice <= 0) return product.priceLabel;
    final lineTotal = unitPrice * quantityValue;
    return '$lineTotal ريال';
  }

  bool get canConfirmPurchase {
    final quantityText = quantityController.text.trim();
    final quantity = int.tryParse(quantityText);
    final hasValidQuantity =
        quantityText.isNotEmpty && quantity != null && quantity > 0;
    final hasDeliveryMethod = selectedDeliveryMethod != null;
    final hasDeliveryLocation = deliveryLocationController.text.trim().isNotEmpty;
    return hasValidQuantity && hasDeliveryMethod && hasDeliveryLocation;
  }

  String? validateBeforePurchase() {
    final quantityText = quantityController.text.trim();
    if (quantityText.isEmpty) {
      return 'يرجى إدخال الكمية المطلوبة';
    }

    final quantity = int.tryParse(quantityText);
    if (quantity == null || quantity <= 0) {
      return 'يرجى إدخال كمية صحيحة';
    }

    if (selectedDeliveryMethod == null) {
      return 'يرجى اختيار طريقة الاستلام';
    }

    if (deliveryLocationController.text.trim().isEmpty) {
      return 'يرجى إدخال موقع التسليم';
    }

    return null;
  }

  String get totalLabel {
    return lineItemPriceLabel;
  }

  String get selectedPaymentValue {
    switch (selectedPayment) {
      case PaymentMethod.cashOnDelivery:
        return 'cash_on_delivery';
      case PaymentMethod.bankTransfer:
        return 'bank_transfer';
      case PaymentMethod.bunyanWallet:
        return 'bunyan_wallet';
    }
  }

  Future<OrderSuccessVm?> submitOrder() async {
    final error = validateBeforePurchase();
    if (error != null) return null;

    isSubmitting = true;
    notifyListeners();
    try {
      final orderId = await _repository.createOrder(
        PurchaseProductModel(
          productId: product.productId,
          title: product.title,
          priceLabel: product.priceLabel,
          sellerName: product.sellerName,
          imageUrl: product.imageUrl,
          rating: product.rating,
          quantity: quantityValue,
          deliveryMethod: selectedDeliveryMethod,
          deliveryLocation: deliveryLocationController.text.trim(),
          notes: notesController.text.trim(),
          paymentMethod: selectedPaymentValue,
        ),
      );
      return OrderSuccessVm(
        orderId: orderId,
        productId: product.productId,
        orderNumber: 'BN-$orderId',
        productName: product.title,
        sellerName: product.sellerName,
        imagePath: product.imageUrl,
        quantity: '$quantityValue',
        price: lineItemPriceLabel,
        deliveryMethod: selectedDeliveryMethod!,
        location: deliveryLocationController.text.trim(),
        eta: 'خلال 3-5 أيام عمل',
        total: totalLabel,
      );
    } catch (_) {
      return null;
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    quantityController.removeListener(_onRequiredFieldChanged);
    deliveryLocationController.removeListener(_onRequiredFieldChanged);
    quantityController.dispose();
    deliveryLocationController.dispose();
    notesController.dispose();
    super.dispose();
  }
}
