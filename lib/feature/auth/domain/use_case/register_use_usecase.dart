import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:stockvision_app/app/usecase/usease.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/auth/domain/entity/auth_entity.dart';
import 'package:stockvision_app/feature/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String fname;
  final String lname;
  final String email;
  final String phoneNo;
  final String address;
  final String username;
  final String password;

  const RegisterUserParams({
    required this.fname,
    required this.lname,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props =>
      [fname, lname, email, phoneNo, address, username, password];

  // Validation method
  String? validate() {
    if (fname.isEmpty || lname.isEmpty) return 'Name fields cannot be empty';
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
    final validationError = params.validate();
    if (validationError != null) {
      return Future.value(Left(Failure(
          message: validationError))); // You can return the failure here
    }

    final authEntity = AuthEntity(
      fName: params.fname,
      lName: params.lname,
      email: params.email,
      phoneNo: params.phoneNo,
      address: params.address,
      username: params.username,
      password: params.password,
    );
    return repository.registerCustomer(authEntity);
  }
}
