// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:stockvision_app/feature/auth/presentation/view/loginscreen_view.dart';
// import 'package:stockvision_app/feature/auth/presentation/view_model/login/bloc/login_bloc.dart';
// import 'package:stockvision_app/feature/onboarding/presentation/view/onbordingscreen_view.dart';

// class OnboardingCubit extends Cubit<void> {
//   OnboardingCubit(this._loginBloc) : super(null);

//   final LoginBloc _loginBloc;

//   Future<void> init(BuildContext context) async {
//     // Simulate onboarding delay or logic
//     await Future.delayed(const Duration(seconds: 2), () async {
//       // Navigate to Onboarding Screen
//       if (context.mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OnboardingScreen(
//               onComplete: () {
//                 // Navigate to Login Screen after onboarding
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BlocProvider.value(
//                       value: _loginBloc,
//                       child: const LoginscreenView(),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       }
//     });
//   }
// }
