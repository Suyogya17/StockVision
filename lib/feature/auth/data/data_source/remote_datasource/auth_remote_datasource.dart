import 'dart:io';

import 'package:dio/dio.dart';
import 'package:stockvision_app/app/constants/api_endpoints.dart';
import 'package:stockvision_app/app/shared_prefs/userId_shared_prefs.dart%207-49-15-915%E2%80%AFPM.dart';
import 'package:stockvision_app/feature/auth/data/data_source/auth_data_source.dart';
import 'package:stockvision_app/feature/auth/domain/entity/auth_entity.dart';

class AuthRemoteDatasource implements IAuthDataSource {
  final Dio _dio;
  final UserIdSharedPrefs userIdSharedPrefs;
  AuthRemoteDatasource(this._dio, this.userIdSharedPrefs);
  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> loginCustomer(String username, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "username": username,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        final str = response.data['token'];
        final cred = response.data['cred'];
        userIdSharedPrefs.setUser(cred);
        print("USER SAVED:::: $cred");
        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> registerCustomer(AuthEntity customer) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.register,
        data: {
          "fName": customer.fName,
          "lName": customer.lName,
          "image": customer.image,
          "phoneNo": customer.phoneNo,
          "email": customer.email,
          "username": customer.username,
          "password": customer.password,
          "address": customer.address,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
        // If user already exits than
      } else if (response.statusCode == 400 &&
          response.data['error'] == 'User already exists') {
        throw Exception('User already exists');

        //  failed to register
      } else {
        throw Exception('Failed to register: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('DioException: ${e.message}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );
      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> getUserById(String username) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }
}
