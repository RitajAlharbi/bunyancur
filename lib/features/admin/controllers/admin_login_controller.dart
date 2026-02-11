import 'package:flutter/material.dart';

/// Controller responsible for the temporary Admin login flow.
///
/// - Uses only mock credentials (username: `admin`, password: `admin`).
/// - Keeps all validation and decision logic away from the UI layer.
class AdminLoginController extends ChangeNotifier {
  AdminLoginController() {
    usernameController.addListener(_onFieldsChanged);
    passwordController.addListener(_onFieldsChanged);
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

  /// Form is considered valid when both fields are non‑empty.
  bool get isFormValid =>
      usernameController.text.trim().isNotEmpty &&
      passwordController.text.trim().isNotEmpty;

  /// Evaluates the current credentials and returns the destination that
  /// the UI should navigate to.
  AdminLoginDestination evaluateDestination() {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username == 'admin' && password == 'admin') {
      return AdminLoginDestination.adminHome;
    }
    return AdminLoginDestination.clientHome;
  }

  /// Simulates a short login process and returns the navigation target.
  ///
  /// This does **not** call any backend and should later be replaced by
  /// real authentication logic.
  Future<AdminLoginDestination> submit() async {
    if (!isFormValid) {
      return AdminLoginDestination.clientHome;
    }

    _setSubmitting(true);

    // Small delay to mimic a network call without actually calling one.
    await Future<void>.delayed(const Duration(milliseconds: 300));

    final destination = evaluateDestination();

    _setSubmitting(false);
    return destination;
  }

  void _onFieldsChanged() {
    notifyListeners();
  }

  void _setSubmitting(bool value) {
    if (_isSubmitting == value) return;
    _isSubmitting = value;
    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

/// Indicates where the app should navigate after a login attempt.
enum AdminLoginDestination {
  adminHome,
  clientHome,
}

