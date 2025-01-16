part of 'registration_bloc.dart';

class RegistrationState {
  final bool isLoading;
  final bool isSuccess;

  RegistrationState({
    required this.isLoading,
    required this.isSuccess,
  });

  RegistrationState.initial()
      : isLoading = false,
        isSuccess = false;

  RegistrationState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return RegistrationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
