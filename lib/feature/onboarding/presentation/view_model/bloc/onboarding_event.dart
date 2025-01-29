part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class OnboardingNextPageEvent extends OnboardingEvent {}

class OnboardingSkipEvent extends OnboardingEvent {}

class OnboardingDoneEvent extends OnboardingEvent {}
