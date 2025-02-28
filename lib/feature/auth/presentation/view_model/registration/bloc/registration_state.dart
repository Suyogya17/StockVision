part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;
  final AuthEntity? user;

  const RegistrationState({
    required this.isLoading,
    required this.isSuccess,
    this.user,
    this.imageName,
  });

  const RegistrationState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null,
        user = null;

  RegistrationState copyWith(
      {bool? isLoading, bool? isSuccess, String? imageName, AuthEntity? user}) {
    return RegistrationState(
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        imageName: imageName ?? this.imageName,
        user: user);
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, imageName];
}
