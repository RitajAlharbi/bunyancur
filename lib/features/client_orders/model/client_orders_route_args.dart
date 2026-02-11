import '../../create_project/models/create_project_form_data.dart';

/// Arguments passed when navigating to ClientOrdersScreen.
class ClientOrdersRouteArgs {
  final int initialTabIndex;
  final CreateProjectFormData? formData;

  const ClientOrdersRouteArgs({
    this.initialTabIndex = 0,
    this.formData,
  });
}
