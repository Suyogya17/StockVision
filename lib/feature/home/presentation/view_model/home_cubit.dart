import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockvision_app/app/di/di.dart';
import 'package:stockvision_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:stockvision_app/feature/auth/presentation/view/loginscreen_view.dart';
import 'package:stockvision_app/feature/auth/presentation/view_model/login/bloc/login_bloc.dart';
import 'package:stockvision_app/feature/home/presentation/view_model/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final IAuthRepository authRepository;

  HomeCubit({required this.authRepository}) : super(HomeState.initial());

  /// Handle bottom navigation tab changes
  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  /// Logout user and navigate to login screen
  void logout(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<LoginBloc>(),
              child: const LoginscreenView(),
            ),
          ),
        );
      }
    });
  }
}
