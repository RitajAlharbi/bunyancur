/// View model for a single offer within a pending order.
class OfferVM {
  final String id;
  final String contractorName;
  final String offerPrice;
  final String duration;
  final String shortDescription;

  const OfferVM({
    required this.id,
    required this.contractorName,
    required this.offerPrice,
    required this.duration,
    required this.shortDescription,
  });
}
