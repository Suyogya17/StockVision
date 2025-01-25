// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      fName: json['fName'] as String,
      lName: json['lName'] as String,
      image: json['image'] as String?,
      phoneNo: json['phoneNo'] as String,
      username: json['username'] as String,
      password: json['password'] as String?,
      email: json['email'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fName': instance.fName,
      'lName': instance.lName,
      'image': instance.image,
      'phoneNo': instance.phoneNo,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'address': instance.address,
    };
