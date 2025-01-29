import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockvision_app/feature/auth/presentation/view/loginscreen_view.dart';
import 'package:stockvision_app/feature/onboarding/presentation/view_model/bloc/onboarding_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<OnboardingBloc, OnboardingState>(
            listener: (context, state) {
              if (state is OnboardingCompleted) {
                // Navigate to the Login Screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginscreenView()),
                );
              }
            },
            builder: (context, state) {
              int currentPage = 0;
              if (state is OnboardingPageChanged) {
                currentPage = state.currentPage;
              }

              final List<Map<String, String>> onboardingData = [
                {
                  'title': 'Track Your Inventory',
                  'description':
                      'Monitor your stock levels in real-time and stay organized.',
                  'image': 'assets/images/track_inventory.png',
                },
                {
                  'title': 'Set Smart Alerts',
                  'description': 'Get notified when stock is running low.',
                  'image': 'assets/images/smart_inventory.png',
                },
                {
                  'title': 'Analyze Trends',
                  'description':
                      'Make informed decisions with powerful analytics.',
                  'image': 'assets/images/analyze_trends.png',
                },
              ];

              return Column(
                children: [
                  // PageView displaying onboarding slides
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (index) {
                        context
                            .read<OnboardingBloc>()
                            .add(OnboardingNextPageEvent());
                      },
                      itemCount: onboardingData.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              onboardingData[index]['image']!,
                              height: 250.0,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              onboardingData[index]['title']!,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Text(
                                onboardingData[index]['description']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // Footer with Skip, Dots Indicator, and Next/Done button
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Skip Button
                        TextButton(
                          onPressed: () {
                            context
                                .read<OnboardingBloc>()
                                .add(OnboardingSkipEvent());
                          },
                          child: const Text(
                            'Skip',
                            style:
                                TextStyle(color: Colors.orange, fontSize: 16),
                          ),
                        ),
                        // Dots Indicator
                        Row(
                          children: List.generate(
                            onboardingData.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: currentPage == index ? 12 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentPage == index
                                    ? Colors.orange
                                    : Colors.grey.shade400,
                              ),
                            ),
                          ),
                        ),
                        // Next/Done Button
                        TextButton(
                          onPressed: currentPage == onboardingData.length - 1
                              ? () {
                                  context
                                      .read<OnboardingBloc>()
                                      .add(OnboardingDoneEvent());
                                }
                              : () {
                                  context
                                      .read<OnboardingBloc>()
                                      .add(OnboardingNextPageEvent());
                                },
                          child: Text(
                            currentPage == onboardingData.length - 1
                                ? 'Done'
                                : 'Next',
                            style: const TextStyle(
                                color: Colors.orange, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
