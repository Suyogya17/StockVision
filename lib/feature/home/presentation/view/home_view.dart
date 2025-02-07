import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockvision_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:stockvision_app/feature/home/presentation/view_model/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // final bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('StockVision'),
        // centerTitle: true,
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
          ],
        ),
        backgroundColor: Colors.orange,
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.logout),
          //   onPressed: () {
          //     // Logout code
          //     showMySnackBar(
          //       context: context,
          //       message: 'Logging out...',
          //       color: Colors.red,
          //     );

          //     context.read<HomeCubit>().logout(context);
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {},
          ),
        ],
      ),
      // body: _views.elementAt(_selectedIndex),
      body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return state.views.elementAt(state.selectedIndex);
      }),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: Colors.orange,
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.orange,
                icon: Icon(Icons.shopping_cart),
                label: 'Product',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.orange,
                icon: Icon(Icons.card_travel),
                label: 'Order',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.orange,
                icon: Icon(Icons.settings),
                label: 'Setting',
              ),
            ],
            currentIndex: state.selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            onTap: (index) {
              context.read<HomeCubit>().onTabTapped(index);
            },
          );
        },
      ),
    );
  }
}
