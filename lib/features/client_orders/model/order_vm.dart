import 'offer_vm.dart';

enum OrderStatus {
  active,
  pending,
  completed,
}

/// Simple view model for a single order card.
class OrderVM {
  final String id;
  final String orderId;
  final String projectId;
  final String title;
  final String projectName;
  final String projectTypeKey;
  final OrderStatus status;
  final String dateLabel;
  final String dateValue;
  final String personLabel;
  final String personValue;
  final String price;
  final String orderNumber;
  final double progressPercent;
  final List<OfferVM> offers;

  const OrderVM({
    required this.id,
    required this.orderId,
    required this.projectId,
    required this.title,
    required this.projectName,
    required this.projectTypeKey,
    required this.status,
    required this.dateLabel,
    required this.dateValue,
    required this.personLabel,
    required this.personValue,
    required this.price,
    required this.orderNumber,
    this.progressPercent = 0,
    this.offers = const [],
  });
}
