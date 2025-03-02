import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockvision_app/core/error/failure.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;
  TokenSharedPrefs(this._sharedPreferences);

  // Save token to SharedPreferences
  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString('token', token);
      var token1 = _sharedPreferences.getString('token');
      print('TOKEN SAVED:: $token1');
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Retrieve token from SharedPreferences
  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      return Right(token ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Save user ID to SharedPreferences
  Future<Either<Failure, void>> saveUserId(String userId) async {
    try {
      await _sharedPreferences.setString('userId', userId);
      print("Saved User ID: $userId"); // Debug log
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Get user ID from SharedPreferences
  Future<Either<Failure, String>> getUserId() async {
    try {
      final userId = _sharedPreferences.getString('userId');
      if (userId == null || userId.isEmpty) {
        return const Left(SharedPrefsFailure(message: 'User ID not found.'));
      }
      print("Retrieved User ID: $userId"); // Debug log
      return Right(userId);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Save user data to SharedPreferences
  Future<bool> setUser(Map<String, dynamic> userData) async {
    try {
      var userDataString = jsonEncode(userData);
      print("Serialized User: $userDataString"); // Debug log
      print("Serialized User: ${userDataString.runtimeType}"); // Debug log

      bool isSaved = await _sharedPreferences.setString('user', userDataString);
      print("User data saved: $isSaved");

      return isSaved;
    } catch (e) {
      print("Error saving user data: ${e.toString()}"); // Debug log
      return false;
    }
  }

  // Retrieve user data from SharedPreferences
  Future<Map<String, dynamic>?> getUser() async {
    try {
      var userDataString = _sharedPreferences.getString('user');
      if (userDataString == null || userDataString.isEmpty) {
        print("No user data found in SharedPreferences.");
        return null;
      }
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData;
    } catch (e) {
      return null;
    }
  }

  // Delete user data from SharedPreferences
  Future<bool> deleteUser() async {
    try {
      await _sharedPreferences.remove('user');
      return true;
    } catch (e) {
      return false;
    }
  }

  // Update user data in SharedPreferences
  Future<bool> updateUser(Map<String, dynamic> updatedUserData) async {
    print("updateUser called with data: $updatedUserData"); // Debug log
    try {
      // Retrieve the current user data
      final currentUserData = await getUser();
      print("getting user $currentUserData");

      if (currentUserData == null) {
        print("No user data found in SharedPreferences.");
        return false; // No user data found to update
      }

      // Merge old data with new updated data
      final Map<String, dynamic> updatedData = {
        ...currentUserData, // Keep existing data
        ...updatedUserData, // Overwrite with new values
      };
      print("Updated User Data to Merge: $updatedUserData");

      // Save the updated data back to SharedPreferences
      bool isUpdated = await setUser(updatedData);
      print("Is UPDATED::::: $isUpdated");
      return isUpdated;
    } catch (e) {
      print("Error updating user data: ${e.toString()}");
      return false;
    }
  }
}
