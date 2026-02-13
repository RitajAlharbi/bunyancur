class OrderSuccessVm {
  final String? orderId;
  final String? productId;
  final String orderNumber;
  final String productName;
  final String sellerName;
  final String imagePath;
  final String quantity;
  final String price;
  final String deliveryMethod;
  final String location;
  final String eta;
  final String total;

  const OrderSuccessVm({
    this.orderId,
    this.productId,
    required this.orderNumber,
    required this.productName,
    required this.sellerName,
    required this.imagePath,
    required this.quantity,
    required this.price,
    required this.deliveryMethod,
    required this.location,
    required this.eta,
    required this.total,
  });
}
