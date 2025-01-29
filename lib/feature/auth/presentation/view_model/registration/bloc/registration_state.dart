part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;

  const RegistrationState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
  });

  const RegistrationState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null;

  RegistrationState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
  }) {
    return RegistrationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, imageName];
}
