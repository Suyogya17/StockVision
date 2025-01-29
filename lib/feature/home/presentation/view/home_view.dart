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
        title: const Text('StockVision'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        // actions: [
        //   // IconButton(
        //   //   icon: const Icon(Icons.logout),
        //   //   onPressed: () {
        //   //     // Logout code
        //   //     showMySnackBar(
        //   //       context: context,
        //   //       message: 'Logging out...',
        //   //       color: Colors.red,
        //   //     );

        //   //     // context.read<HomeCubit>().logout();
        //   //   },
        //   // ),
        //   // Switch(
        //   //   value: _isDarkTheme,
        //   //   onChanged: (value) {
        //   //     // Change theme
        //   //     // setState(() {
        //   //     //   _isDarkTheme = value;
        //   //     // });
        //   //   },
        //   // ),
        // ],
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
                icon: Icon(Icons.shopping_cart),
                label: 'Product',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_travel),
                label: 'Order',
              ),
              BottomNavigationBarItem(
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
