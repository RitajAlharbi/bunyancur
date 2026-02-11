import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/auth_state.dart';
import '../model/profile_vm.dart';

class AuthController extends ChangeNotifier {
  AuthUiState _state = const AuthUiState();

  AuthUiState get state => _state;

  SupabaseClient get _client => Supabase.instance.client;

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String role,
    String? phone,
    String? commercialRegister,
  }) async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final res = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName, 'role': role, 'phone': phone},
      );
      final user = res.user;
      if (user == null) {
        _state = _state.copyWith(
          isLoading: false,
          error: 'فشل إنشاء الحساب',
        );
        notifyListeners();
        return;
      }
      await _insertProfile(
        id: user.id,
        fullName: fullName,
        email: email,
        phone: phone,
        role: role,
        commercialRegister: commercialRegister,
      );
      await getMyProfile();
      _state = _state.copyWith(isLoading: false, error: null);
      notifyListeners();
    } on AuthException catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.message,
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      notifyListeners();
    }
  }

  Future<void> _insertProfile({
    required String id,
    required String fullName,
    required String email,
    String? phone,
    required String role,
    String? commercialRegister,
  }) async {
    await _client.from('profiles').insert({
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'role': role,
      'commercial_register': commercialRegister,
    });
  }

  Future<void> login({required String email, required String password}) async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      await _client.auth.signInWithPassword(email: email, password: password);
      await getMyProfile();
      _state = _state.copyWith(isLoading: false, error: null);
      notifyListeners();
    } on AuthException catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.message,
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      notifyListeners();
    }
  }

  Future<void> getMyProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) {
      _state = _state.copyWith(profile: null);
      notifyListeners();
      return;
    }
    try {
      final res = await _client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();
      if (res != null) {
        _state = _state.copyWith(profile: ProfileVm.fromJson(res));
      } else {
        _state = _state.copyWith(profile: null);
      }
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(profile: null);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();
    try {
      await _client.auth.signOut();
      _state = const AuthUiState();
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      notifyListeners();
    }
  }

  Future<void> forgotPassword({required String email}) async {
    _state = _state.copyWith(
      isLoading: true,
      error: null,
      forgotPasswordSuccess: false,
    );
    notifyListeners();

    try {
      await _client.auth.resetPasswordForEmail(email);
      _state = _state.copyWith(
        isLoading: false,
        error: null,
        forgotPasswordSuccess: true,
      );
      notifyListeners();
    } on AuthException catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.message,
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      notifyListeners();
    }
  }

  void clearError() {
    _state = _state.copyWith(error: null);
    notifyListeners();
  }
}
