import 'package:flutter/material.dart';
import 'package:stockvision_app/core/error/failure.dart';

void showFailureSnackBar(BuildContext context, Failure failure) {
  final snackBar = SnackBar(
    content: Text(failure.message),
    backgroundColor: Colors.red, // Customize the color if needed
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
