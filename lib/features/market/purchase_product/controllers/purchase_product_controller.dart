import 'package:flutter/material.dart';
import '../models/purchase_product_model.dart';

enum PaymentMethod { cashOnDelivery, bankTransfer, bunyanWallet }

class PurchaseProductController extends ChangeNotifier {
  final PurchaseProductModel product;

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

  PurchaseProductController({required this.product});

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

  String get totalLabel {
    return product.priceLabel;
  }

  @override
  void dispose() {
    quantityController.dispose();
    deliveryLocationController.dispose();
    notesController.dispose();
    super.dispose();
  }
}
