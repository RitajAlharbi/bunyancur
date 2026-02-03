import 'package:flutter/foundation.dart';
import '../models/role_type.dart';

class RolesController extends ChangeNotifier {
  RoleType? selectedRole;

  void onRoleSelected(RoleType role) {
    selectedRole = role;
    notifyListeners();
  }
}
