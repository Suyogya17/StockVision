import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:stockvision_app/app/usecase/usease.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/auth/domain/entity/auth_entity.dart';
import 'package:stockvision_app/feature/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String fname;
  final String lname;
  final String phoneNo;
  final String address;
  final String username;
  final String password;

  const RegisterUserParams({
    required this.fname,
    required this.lname,
    required this.phoneNo,
    required this.address,
    required this.username,
    required this.password,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.fname,
    required this.lname,
    required this.phoneNo,
    required this.address,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props =>
      [fname, lname, phoneNo, address, username, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      fName: params.fname,
      lName: params.lname,
      phoneNo: params.phoneNo,
      address: params.address,
      username: params.username,
      password: params.password,
    );
    return repository.registerCustomer(authEntity);
  }
}
