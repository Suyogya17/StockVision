import 'package:flutter/material.dart';
import 'package:stockvision_app/model/user.dart';
import 'package:stockvision_app/core/common/user_listview.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the arguments passed from the login screen
    final User user = ModalRoute.of(context)?.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(title: Text(' Welcome, ${user.fname}')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome this is your dashboard , ${user.fname}'),
            // More widgets based on user data
          ],
        ),
      ),
    );
  }
}
