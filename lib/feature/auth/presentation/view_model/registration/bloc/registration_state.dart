part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  final bool isLoading;
  final bool isSuccess;

  const RegistrationState({
    required this.isLoading,
    required this.isSuccess,
  });

  factory RegistrationState.initial() {
    return const RegistrationState(
      isLoading: false,
      isSuccess: false,
    );
  }

  RegistrationState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return RegistrationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess];
}
