/// Dummy model for professional reviews list.
class ProfessionalReviewVm {
  final String id;
  final String reviewerName;
  final String timeLabel;
  final int starCount;
  final String comment;

  const ProfessionalReviewVm({
    required this.id,
    required this.reviewerName,
    required this.timeLabel,
    required this.starCount,
    required this.comment,
  });
}
