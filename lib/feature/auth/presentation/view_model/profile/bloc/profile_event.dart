part of 'profile_bloc.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class NavigatetoProfile extends ProfileEvent {
  final BuildContext context;
  final Widget destination;

  const NavigatetoProfile({required this.context, required this.destination});
}

class UpdateProfilePicture extends ProfileEvent {}

class UpdateUserEvent extends ProfileEvent {
  final AuthEntity user;

  const UpdateUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}
