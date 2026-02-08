import 'package:flutter/foundation.dart';

import '../model/designer_home_model.dart';

class DesignerHomeController extends ChangeNotifier {
  static const String _ctaText = 'عرض تفاصيل';

  final List<DesignerProjectCardModel> currentProjects = const [
    DesignerProjectCardModel(
      id: 'cp1',
      title: 'تصميم مجلس فاخر',
      subtitle1: 'العميل: نوف خالد',
      subtitle2: 'الخرج',
      imagePathOrUrl: 'assets/images/Rectangle (1).png',
      actionText: _ctaText,
    ),
    DesignerProjectCardModel(
      id: 'cp2',
      title: 'تصميم داخلي لصالة المعيشة',
      subtitle1: 'العميل: صالح محمد',
      subtitle2: 'الخرج',
      imagePathOrUrl: 'assets/images/Rectangle (2).png',
      actionText: _ctaText,
    ),
  ];

  final List<DesignerProjectCardModel> availableProjects = const [
    DesignerProjectCardModel(
      id: 'ap1',
      title: 'تصميم غرفة نوم',
      imagePathOrUrl: 'assets/images/Rectangle.png',
      actionText: _ctaText,
    ),
    DesignerProjectCardModel(
      id: 'ap2',
      title: 'تصميم فيلا',
      imagePathOrUrl: 'assets/images/service1.png',
      actionText: _ctaText,
    ),
  ];
}
