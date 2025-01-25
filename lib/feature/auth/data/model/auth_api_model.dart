import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stockvision_app/feature/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String fName;
  final String lName;
  final String? image;
  final String phoneNo;
  final String username;
  final String? password;
  final String email;
  final String address;

  const AuthApiModel({
    this.id,
    required this.fName,
    required this.lName,
    required this.image,
    required this.phoneNo,
    required this.username,
    required this.password,
    required this.email,
    required this.address,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: id,
      fName: fName,
      lName: lName,
      phoneNo: phoneNo,
      username: username,
      password: password ?? '',
      email: email,
      address: address,
    );
  }

  // From Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      fName: entity.fName,
      lName: entity.lName,
      image: entity.image,
      phoneNo: entity.phoneNo,
      username: entity.username,
      password: entity.password,
      email: entity.email,
      address: entity.address,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [fName, lName, image, phoneNo, email, username, password, address];
}
