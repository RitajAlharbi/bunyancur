import 'profile_vm.dart';

/// Holds auth UI state: loading, error, profile, and forgot-password success.
class AuthUiState {
  final bool isLoading;
  final String? error;
  final ProfileVm? profile;
  final bool forgotPasswordSuccess;

  const AuthUiState({
    this.isLoading = false,
    this.error,
    this.profile,
    this.forgotPasswordSuccess = false,
  });

  AuthUiState copyWith({
    bool? isLoading,
    String? error,
    ProfileVm? profile,
    bool? forgotPasswordSuccess,
  }) {
    return AuthUiState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      profile: profile ?? this.profile,
      forgotPasswordSuccess:
          forgotPasswordSuccess ?? this.forgotPasswordSuccess,
    );
  }
}
