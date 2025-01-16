import 'package:flutter/material.dart';
import 'package:stockvision_app/core/common/card/cardsview.dart';
import 'package:stockvision_app/feature/home/presentation/view/bottom_view/history_view.dart';
import 'package:stockvision_app/feature/home/presentation/view/bottom_view/products_view.dart';
import 'package:stockvision_app/feature/home/presentation/view/bottom_view/setting_view.dart';

class DashboardPage extends StatelessWidget {
  final user;
  final int selectedIndex;
  final Function(int) onTabChange;

  const DashboardPage({
    super.key,
    required this.user,
    required this.selectedIndex,
    required this.onTabChange,
  });

  List<Widget> get _lstBottomScreen => [
        const DashboardPageContent(),
        const ProductsView(),
        const HistoryView(),
        const SettingView(),
      ];

  @override
  Widget build(BuildContext context) {
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
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 15,
                      color: Colors.red,
                    ),
                    Text(
                      user.address,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
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
        elevation: 20,
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: _lstBottomScreen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.orange,
        selectedItemColor: const Color.fromARGB(255, 255, 17, 0),
        unselectedItemColor: Colors.black,
        iconSize: 30,
        currentIndex: selectedIndex,
        onTap: onTabChange,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
      ),
    );
  }
}

class DashboardPageContent extends StatelessWidget {
  const DashboardPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 15);

    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            gap,
            MyCard(
              title: 'card 1',
              color: Colors.amber,
              width: double.infinity,
            ),
            gap,
            Row(
              children: [
                Expanded(
                  child: MyCard(
                    title: 'card 2',
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: MyCard(
                    title: 'card 3',
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            gap,
            MyCard(
              title: 'card 4',
              color: Colors.grey,
              width: 1000.0,
              height: 500,
            ),
            gap,
            MyCard(
              title: 'card 5',
              color: Colors.blue,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
