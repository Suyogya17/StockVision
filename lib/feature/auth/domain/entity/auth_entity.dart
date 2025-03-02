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

  // from JSON
  factory AuthEntity.fromJson(Map<String, dynamic> json) {
    return AuthEntity(
      // Ensure all fields are treated as String
      userId: json['_id']?.toString(),
      fName: json['fName']?.toString() ?? '',
      lName: json['lName']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      phoneNo: json['phoneNo']?.toString() ?? '',
      image: json['image']?.toString(),
      password: json['password']?.toString() ?? '',
    );
  }

  // to JSON
  Map<String, dynamic> toJson() => {
        '_id': userId,
        'fName': fName,
        'lName': lName,
        'email': email,
        'address': address,
        'username': username,
        'phoneNo': phoneNo,
        'image': image,
        'password': password,
      };

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
