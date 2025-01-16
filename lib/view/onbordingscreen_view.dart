// import 'package:flutter/material.dart';

// import '../feature/auth/presentation/view/loginscreen_view.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   final List<Map<String, String>> _onboardingData = [
//     {
//       'title': 'Track Your Inventory',
//       'description':
//           'Monitor your stock levels in real-time and stay organized.',
//       'image': 'assets/images/track_inventory.png',
//     },
//     {
//       'title': 'Set Smart Alerts',
//       'description': 'Get notified when stock is running low.',
//       'image': 'assets/images/smart_inventory.png',
//     },
//     {
//       'title': 'Analyze Trends',
//       'description': 'Make informed decisions with powerful analytics.',
//       'image': 'assets/images/analyze_trends.png',
//     },
//   ];

//   void _onDone() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const LoginscreenView(
//           registeredUsers: [],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: PageView.builder(
//               controller: _pageController,
//               onPageChanged: (index) {
//                 setState(() {
//                   _currentPage = index;
//                 });
//               },
//               itemCount: _onboardingData.length,
//               itemBuilder: (context, index) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       _onboardingData[index]['image']!,
//                       height: 250,
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       _onboardingData[index]['title']!,
//                       style: const TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                       child: Text(
//                         _onboardingData[index]['description']!,
//                         textAlign: TextAlign.center,
//                         style:
//                             const TextStyle(fontSize: 16, color: Colors.grey),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                   onPressed: _onDone,
//                   child: const Text(
//                     'Skip',
//                     style: TextStyle(color: Colors.orange, fontSize: 16),
//                   ),
//                 ),
//                 Row(
//                   children: List.generate(
//                     _onboardingData.length,
//                     (index) => Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 4),
//                       width: 8,
//                       height: 8,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: _currentPage == index
//                             ? Colors.orange
//                             : Colors.grey.shade400,
//                       ),
//                     ),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: _currentPage == _onboardingData.length - 1
//                       ? _onDone
//                       : () => _pageController.nextPage(
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.easeInOut,
//                           ),
//                   child: Text(
//                     _currentPage == _onboardingData.length - 1
//                         ? 'Done'
//                         : 'Next',
//                     style: const TextStyle(color: Colors.orange, fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
