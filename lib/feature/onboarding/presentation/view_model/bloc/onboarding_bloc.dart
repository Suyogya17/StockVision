import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  int _currentPage = 0; // Tracks the current page of the onboarding

  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingNextPageEvent>((event, emit) {
      if (_currentPage < 2) {
        _currentPage++;
        emit(OnboardingPageChanged(_currentPage)); // Update the page
      }
    });

    on<OnboardingSkipEvent>((event, emit) {
      // Skip the onboarding and go directly to the login screen
      emit(OnboardingCompleted());
    });

    on<OnboardingDoneEvent>((event, emit) {
      // Onboarding is done, navigate to login screen or complete process
      emit(OnboardingCompleted());
    });
  }
}
