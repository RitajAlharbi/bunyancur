import 'package:flutter/material.dart';

import '../../../core/routing/routes.dart';
import '../model/project_details_model.dart';

class ProjectDetailsController extends ChangeNotifier {
  final ProjectDetailsModel project;

  ProjectDetailsController({required this.project});

  void onBottomNavTap(int index, BuildContext context) {
    final navigator = Navigator.of(context);
    switch (index) {
      case 0:
        navigator.pushReplacementNamed(Routes.contractorHomeView);
        break;
      case 1:
        // Already on Projects
        break;
      case 2:
        navigator.pushReplacementNamed(Routes.contractorHomeView);
        break;
      case 3:
        navigator.pushReplacementNamed(Routes.contractorHomeView);
        break;
      case 4:
        navigator.pushReplacementNamed(Routes.contractorHomeView);
        break;
    }
  }
}
