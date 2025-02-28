part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final AuthEntity? user;
  final String? errorMessage;

  const ProfileState({
    required this.isLoading,
    required this.isSuccess,
    this.user,
    this.errorMessage,
  });

  const ProfileState.initial()
      : isLoading = false,
        isSuccess = false,
        user = null,
        errorMessage = null;

  ProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    AuthEntity? user,
    String? errorMessage,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, user, errorMessage];
}
