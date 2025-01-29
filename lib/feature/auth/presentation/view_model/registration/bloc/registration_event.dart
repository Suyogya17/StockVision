part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object?> get props => [];
}

class LoadImage extends RegistrationEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}

class RegisterCustomer extends RegistrationEvent {
  final BuildContext context;
  final String fName;
  final String lName;
  final String phoneNo;
  final String email;
  final String address;
  final String username;
  final String password;
  final String? image;

  const RegisterCustomer({
    required this.context,
    required this.fName,
    required this.lName,
    required this.phoneNo,
    required this.email,
    required this.address,
    required this.username,
    required this.password,
    this.image,
  });

  @override
  List<Object?> get props => [
        context,
        fName,
        image,
        lName,
        phoneNo,
        email,
        address,
        username,
        password
      ];
}

class NavigateToLoginEvent extends RegistrationEvent {
  final BuildContext context;

  const NavigateToLoginEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
