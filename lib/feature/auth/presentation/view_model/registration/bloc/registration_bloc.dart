import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockvision_app/app/di/di.dart';
import 'package:stockvision_app/core/common/snackbar/my_snackbar.dart';
import 'package:stockvision_app/feature/auth/domain/use_case/register_use_usecase.dart';
import 'package:stockvision_app/feature/auth/presentation/view/loginscreen_view.dart';
import 'package:stockvision_app/feature/auth/presentation/view_model/login/bloc/login_bloc.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegisterUseCase _registerUseCase;

  RegistrationBloc({
    required RegisterUseCase registerUseCase,
  })  : _registerUseCase = registerUseCase,
        super(RegistrationState.initial()) {
    on<RegisterCustomer>(_onRegisterEvent);
    on<NavigateToLoginEvent>(_onNavigateToLoginEvent);
  }

  void _onRegisterEvent(
    RegisterCustomer event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase.call(RegisterUserParams(
      fname: event.fName,
      lname: event.lName,
      phoneNo: event.phoneNo,
      address: event.address,
      username: event.username,
      password: event.password,
    ));

    result.fold(
      (l) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
            context: event.context, message: "Registration Unsuccessful");
      },
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Registration Successful");

        // Emit the navigation event to go to the login page
        add(NavigateToLoginEvent(context: event.context));
      },
    );
  }

  void _onNavigateToLoginEvent(
    NavigateToLoginEvent event,
    Emitter<RegistrationState> emit,
  ) {
    // This event will navigate to the login screen
    Navigator.of(event.context).pop(); // Close registration screen
    Navigator.of(event.context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt<LoginBloc>(), // Initialize the LoginBloc
          child: const LoginscreenView(), // Navigate to the Login screen
        ),
      ),
    );
  }
}
