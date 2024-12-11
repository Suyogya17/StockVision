import 'package:flutter/material.dart';
import 'package:stockvision_app/model/user.dart';
import 'package:stockvision_app/core/common/cardsview.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)?.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Text(
                user.fname[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fname,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  user.address,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              // Handle scanner action
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification action
            },
          ),
        ],
        backgroundColor: Colors.orange,
        elevation: 20, // Add shadow to the app bar
        centerTitle: false,
        automaticallyImplyLeading: false, // Disable the back button
      ),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card 1
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: MyCard(
                title: 'card 1',
                color: Colors.amber,
                width: 500.0, // Example size
              ),
            ),

            // Cards 2 and 3 side by side with a gap
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                children: [
                  // Card 2
                  Expanded(
                    child: MyCard(
                      title: 'card 2',
                      color: Colors.green,
                      width: 500.0, // Adjust width
                    ),
                  ),
                  SizedBox(width: 16), // Add gap between the two cards
                  // Card 3
                  Expanded(
                    child: MyCard(
                      title: 'card 3',
                      color: Colors.blue,
                      width: 500.0, // Adjust width
                    ),
                  ),
                ],
              ),
            ),

            // Card 4
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: MyCard(
                title: 'card 4',
                color: Colors.grey,
                width: 1000.0,
                height: 500, // Example size
              ),
            ),

            // Card 5
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: MyCard(
                title: 'card 5',
                color: Colors.blue,
                width: 200.0, // Example size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
