import 'package:flutter/material.dart';
import 'package:stockvision_app/model/user.dart';
import 'package:stockvision_app/view/dashboardscreen_view.dart';
import 'package:stockvision_app/view/loginscreen_view.dart';
import 'package:stockvision_app/view/registrationscreen_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<User> registeredUsers = []; // Manage the list of registered users

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginscreenView(registeredUsers: registeredUsers),
        '/register': (context) => RegistrationScreen(
              onUserRegistered: (user) {
                setState(() {
                  registeredUsers.add(user); // Add the new user to the list
                });
              },
            ),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
