import 'package:flutter/material.dart';
import 'package:stockvision_app/model/user.dart';

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
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                // Replace email with address here
                Text(
                  user.address,
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
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
        elevation: 10, // Add shadow to the app bar
        centerTitle: false,
        automaticallyImplyLeading: false, // Disable the back button
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.amber),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              // Expanded(
              //   child: GridView.count(
              //     crossAxisCount: 2,
              //     crossAxisSpacing: 20,
              //     mainAxisSpacing: 20,
              //     children: [
              //       _buildDashboardCard(
              //         icon: Icons.pie_chart,
              //         title: "Analytics",
              //         onTap: () {
              //           // Handle action
              //         },
              //       ),
              //       _buildDashboardCard(
              //         icon: Icons.inventory,
              //         title: "Inventory",
              //         onTap: () {
              //           // Handle action
              //         },
              //       ),
              //       _buildDashboardCard(
              //         icon: Icons.notifications,
              //         title: "Alerts",
              //         onTap: () {
              //           // Handle action
              //         },
              //       ),
              //       _buildDashboardCard(
              //         icon: Icons.settings,
              //         title: "Settings",
              //         onTap: () {
              //           // Handle action
              //         },
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
