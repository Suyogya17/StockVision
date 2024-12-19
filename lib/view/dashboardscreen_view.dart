import 'package:flutter/material.dart';
import 'package:stockvision_app/core/common/cardsview.dart';
import 'package:stockvision_app/model/user.dart';
import 'package:stockvision_app/view/history_view.dart';
import 'package:stockvision_app/view/products_view.dart';
import 'package:stockvision_app/view/setting_view.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late User user;
  int _selectedIndex = 0;

  final List<Widget> _lstBottomScreen = [
    const DashboardPageContent(),
    const ProductsView(),
    const HistoryView(),
    const SettingView(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = ModalRoute.of(context)?.settings.arguments as User;
  }

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
      body: _lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.orange,
        selectedItemColor: const Color.fromARGB(255, 255, 17, 0),
        unselectedItemColor: Colors.black,
        iconSize: 30,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
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
            icon: Icon(
              Icons.settings,
            ),
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
