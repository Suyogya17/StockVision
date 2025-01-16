import 'dart:io';

import 'package:stockvision_app/feature/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginCustomer(String username, String password);

  Future<void> registerCustomer(AuthEntity student);

  Future<AuthEntity> getCurrentUser();

  Future<String> uploadProfilePicture(File file);
}
