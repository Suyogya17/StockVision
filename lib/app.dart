import 'package:flutter/material.dart';
import 'package:stockvision_app/view/loginscreen_view.dart';
import 'package:stockvision_app/view/registrationscreen_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginscreenView(),
        '/register': (context) => const RegistrationScreen(),
      },
    );
  }
}
