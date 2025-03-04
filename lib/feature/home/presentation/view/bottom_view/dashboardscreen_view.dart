import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stockvision_app/feature/auth/presentation/view_model/profile/bloc/profile_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  File? _img; // For storing the image file if the user chooses a new one

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().loadClient();
  }

  // Function to browse image (same as in SettingView)
  Future _browseImage(ImageSource imagesource) async {
    try {
      final image = await ImagePicker().pickImage(source: imagesource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section with User Info Card
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.user == null) {
                  return const Center(child: Text("No users available"));
                } else {
                  final user = state.user!;
                  final String? imageUrl = user.image;
                  final String baseUrl = Platform.isIOS
                      ? "http://127.0.0.1:3000"
                      : "http://10.0.2.2:3000";
                  final String fullImageUrl =
                      imageUrl != null && imageUrl.isNotEmpty
                          ? "$baseUrl/uploads/$imageUrl"
                          : '';

                  return UserInfoCard(
                    username: user.username,
                    email: user.email,
                    imageUrl: _img != null
                        ? _img!.path // Show the chosen image if available
                        : fullImageUrl.isNotEmpty
                            ? fullImageUrl // Use network image if available
                            : '', // Fallback to empty if no image is available
                  );
                }
              },
            ),

            const SizedBox(height: 20),

            // User Stats Section
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                InfoCard(
                  title: 'Total Orders',
                  icon: Icons.shopping_bag,
                  color: Colors.green,
                ),
                InfoCard(
                  title: 'Wishlist Items',
                  icon: Icons.favorite,
                  color: Colors.red,
                ),
                InfoCard(
                  title: 'Pending Payments',
                  icon: Icons.payment,
                  color: Colors.blue,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Recent Activity Section
            const Text(
              'Recent Activity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  ListTile(
                    leading: Icon(Icons.shopping_cart, color: Colors.green),
                    title: Text('Order #1234 placed'),
                    subtitle: Text('2 hours ago'),
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite, color: Colors.red),
                    title: Text('Added "Nike Air Max" to wishlist'),
                    subtitle: Text('1 day ago'),
                  ),
                  ListTile(
                    leading: Icon(Icons.payment, color: Colors.blue),
                    title: Text('Payment of \$50 processed'),
                    subtitle: Text('3 days ago'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoCard extends StatelessWidget {
  final String username;
  final String email;
  final String imageUrl;

  const UserInfoCard({
    super.key,
    required this.username,
    required this.email,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: imageUrl.isNotEmpty
                  ? (imageUrl.startsWith('http') ||
                          imageUrl.startsWith('https'))
                      ? NetworkImage(imageUrl) // Network image if URL
                      : FileImage(
                          File(imageUrl)) // Local file image if available
                  : const AssetImage('assets/images/default_profile.png')
                      as ImageProvider, // Fallback to asset image if no URL
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const InfoCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
