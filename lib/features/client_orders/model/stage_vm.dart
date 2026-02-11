enum StageStatus {
  completed,
  inProgress,
  waiting,
}

class StageVM {
  final String title;
  final int order;
  final StageStatus status;
  final String dateText;
  final int remainingDays;
  final String actionText;

  const StageVM({
    required this.title,
    required this.order,
    required this.status,
    required this.dateText,
    required this.remainingDays,
    required this.actionText,
  });
}
