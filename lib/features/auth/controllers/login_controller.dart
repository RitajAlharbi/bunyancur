import 'package:flutter/material.dart';

/// Controller responsible for the client login form.
///
/// This keeps the phone/password state and simple validation logic
/// separated from the UI layer, following the existing MVC pattern
/// used in the app (for example in the admin login flow).
class LoginController extends ChangeNotifier {
  LoginController() {
    phoneController.addListener(_onFieldsChanged);
    passwordController.addListener(_onFieldsChanged);
  }

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  /// Button is enabled when both fields are non‑empty.
  bool get isFormValid =>
      phoneController.text.trim().isNotEmpty &&
      passwordController.text.trim().isNotEmpty;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void _onFieldsChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

