import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:stockvision_app/app/constants/hive_table_constant.dart';
import 'package:stockvision_app/feature/auth/domain/entity/auth_entity.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.customerTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? customerId;
  @HiveField(1)
  final String fName;
  @HiveField(2)
  final String lName;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final String phoneNo;
  @HiveField(5)
  final String address;
  @HiveField(6)
  final String username;
  @HiveField(7)
  final String password;
  @HiveField(8)
  final String email;

  AuthHiveModel({
    String? customerId,
    required this.fName,
    required this.lName,
    this.image,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.username,
    required this.password,
  }) : customerId = customerId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : customerId = '',
        fName = '',
        lName = '',
        image = '',
        email = '',
        phoneNo = '',
        address = '',
        username = '',
        password = '';

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      customerId: entity.userId,
      fName: entity.fName,
      lName: entity.lName,
      image: entity.image,
      email: entity.email,
      phoneNo: entity.phoneNo,
      address: entity.address,
      username: entity.username,
      password: entity.password,
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: customerId,
      fName: fName,
      lName: lName,
      image: image,
      email: email,
      phoneNo: phoneNo,
      address: address,
      username: username,
      password: password,
    );
  }

  @override
  List<Object?> get props => [
        customerId,
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
