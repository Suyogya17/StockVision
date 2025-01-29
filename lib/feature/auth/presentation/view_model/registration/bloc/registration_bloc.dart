import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockvision_app/core/common/snackbar/my_snackbar.dart';
import 'package:stockvision_app/feature/auth/domain/use_case/register_use_usecase.dart';
import 'package:stockvision_app/feature/auth/domain/use_case/uploadimage_use_usecase.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegisterUseCase _registerUseCase;
  final UploadImageUsecase _uploadImageUsecase;

  RegistrationBloc({
    required RegisterUseCase registerUseCase,
    required UploadImageUsecase uploadImageUsecase,
  })  : _registerUseCase = registerUseCase,
        _uploadImageUsecase = uploadImageUsecase,
        super(const RegistrationState.initial()) {
    on<RegisterCustomer>(_onRegisterEvent);
    // on<NavigateToLoginEvent>(_onNavigateToLoginEvent);
    on<LoadImage>(_onLoadImage);
  }

  // Handles the registration event
  Future<void> _onRegisterEvent(
    RegisterCustomer event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true)); // Set loading state to true

    final result = await _registerUseCase.call(RegisterUserParams(
      fName: event.fName,
      lName: event.lName,
      phoneNo: event.phoneNo,
      email: event.email,
      address: event.address,
      username: event.username,
      password: event.password,
      image: state.imageName,
    ));

    // Handle the result
    result.fold(
      (l) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
            context: event.context, message: l.message, color: Colors.red);
      },
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Registration Successful");
      },
    );
  }

  // handle image
  void _onLoadImage(
    LoadImage event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadImageUsecase.call(
      UploadImageParams(
        file: event.file,
      ),
    );
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
      },
    );
  }

  // Handles navigation to the login screen
}
