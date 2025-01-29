import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:stockvision_app/app/usecase/usease.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/auth/domain/entity/auth_entity.dart';
import 'package:stockvision_app/feature/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String fName;
  final String lName;
  final String email;
  final String phoneNo;
  final String address;
  final String username;
  final String password;
  final String? image;

  const RegisterUserParams({
    required this.fName,
    required this.lName,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.username,
    required this.password,
    this.image,
  });

  @override
  List<Object?> get props =>
      [fName, lName, email, phoneNo, address, username, password];

  // Validation method
  String? validate() {
    if (fName.isEmpty || lName.isEmpty) return 'Name fields cannot be empty';
    if (email.isEmpty || !email.contains('@')) return 'Enter a valid email';
    if (phoneNo.isEmpty || phoneNo.length != 10) return 'Invalid phone number';
    if (username.isEmpty) return 'Username is required';
    if (password.isEmpty || password.length < 6) return 'Password too short';
    return null; // Valid
  }
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      fName: params.fName,
      lName: params.lName,
      email: params.email,
      phoneNo: params.phoneNo,
      address: params.address,
      username: params.username,
      password: params.password,
      image: params.image,
    );
    return repository.registerCustomer(authEntity);
  }
}
