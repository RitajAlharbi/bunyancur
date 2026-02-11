import 'package:flutter/material.dart';

import '../../../models/project_model.dart';
import '../../../screens/submit_offer_screen.dart';

class ContractorProjectDetailsController extends ChangeNotifier {
  ContractorProjectDetailsController({required this.project});

  final ProjectModel project;

  void onBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onSubmitOffer(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const SubmitOfferScreen(),
      ),
    );
  }
}
