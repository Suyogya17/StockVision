import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String fName;
  final String lName;
  final String? image;
  final String phoneNo;
  final String email;
  final String address;
  final String username;
  final String password;

  const AuthEntity({
    this.userId,
    required this.fName,
    required this.lName,
    this.image,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [
        userId,
        fName,
        lName,
        image,
        email,
        phoneNo,
        address,
        username,
        password
      ];
}
